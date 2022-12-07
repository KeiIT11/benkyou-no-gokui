import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ramp/notification/local_notification_service.dart';

import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:ramp/schedule/models/todo_model.dart';
import '../widgets/button_widget.dart';
import '/schedule/models/db_model.dart';
import '/schedule/models/todo_model.dart';

// ignore: camel_case_types
class TimerView extends StatefulWidget {
  final double pomosec;
  final double restsec;

  const TimerView({Key? key, required this.pomosec, required this.restsec})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimerViewState createState() => _TimerViewState();
}

// ignore: camel_case_types
class _TimerViewState extends State<TimerView> with WidgetsBindingObserver {
  //バックグラウンドのテスト用
  DateTime pausedTime = DateTime.now();
  String pastState = "resumed";
  bool isTimerPaused = false; //タイマーが停止中なのか、起動されていないかの違い

  //通知用
  late final LocalNotificationService service;

  //タイマー用

  double pomotime = 120; //仮120 //２５分は1800
  double resttime = 30; //仮30 //５分は300
  double maxseconds = 0;
  double seconds = 0;
  bool isPomodoro = true; //true:pomodoro, false:rest
  Timer? timer;

  //日付指定用
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();

  //データベース用（タスク選択）
  var db = DatabaseConnect();
  String? selectedItem = "";
  List<Todo> list = [];

  @override
  void initState() {
    //通知を初期化
    service = LocalNotificationService();
    service.intialize();
    //タスク選択用
    selectedDay = DateTime.utc(now.year, now.month, now.day);
    //タイマー用秒数受け取り
    pomotime = widget.pomosec;
    resttime = widget.restsec;
    maxseconds = pomotime;
    seconds = pomotime;

    //background test
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// ライフサイクルが変更された際に呼び出される関数をoverrideして、変更を検知
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // バックグラウンドに遷移した時
      pastState = "paused";
      print("background");
      _handleOnPaused();
    } else if (state == AppLifecycleState.resumed) {
      print("foreground");
      // フォアグラウンドに復帰した時
      if (pastState != "resumed") {
        _handleOnResumed();
      }
      pastState = "resumed";
    }
  }

  /// アプリがバックグラウンドに遷移した際のハンドラ
  void _handleOnPaused() async {
    bool isRunning = timer == null ? false : timer!.isActive;
    pausedTime = DateTime.now(); // バックグラウンドに遷移した時間を記録

    if (isRunning) {
      //タイマーが起動中にバックに行くと、通知送る。
      isTimerPaused = false;
      timer?.cancel(); // タイマーを停止する
      if (isPomodoro) {
        await service.showScheduledNotification(
          id: 1,
          title: "ポモドーロ終了！",
          body: "お疲れ様〜",
          seconds: seconds.ceil(),
          sound: "pomo_end.wav",
        );
      } else {
        await service.showScheduledNotification(
          id: 1,
          title: "休憩終了！",
          body: "もういっちょ頑張ろう！",
          seconds: seconds.ceil(),
          sound: "rest_end.wav",
        );
      }
    } else {
      //停止中にバックグラウンド行っても何も行わない。
      isTimerPaused = true;
    }
  }

  /// アプリがフォアグラウンドに復帰した際のハンドラ
  void _handleOnResumed() {
    //if (_isTimerPaused == null) return; // タイマーが動いてなければ何もしない
    Duration backgroundDuration =
        DateTime.now().difference(pausedTime); // バックグラウンドでの経過時間
    if (!isTimerPaused) {
      //もしタイマーが起動中だったら
      // バックグラウンドでの経過時間が終了予定を超えていた場合（この場合は通知実行済みのはず）
      if (seconds < backgroundDuration.inSeconds.toDouble()) {
        if (isPomodoro) {
          //ポモドーロ終了時
          if (mounted) {
            setState(() {
              maxseconds = resttime;
              seconds = resttime;
              isPomodoro = false;
              isTimerPaused = false;
            });
          }
        } else {
          if (mounted) {
            //休憩終了時
            setState(() {
              maxseconds = pomotime;
              seconds = pomotime;
              isPomodoro = true;
              isTimerPaused = false;
            });
          }
        } // 時間をリセットする
      } else {
        if (mounted) {
          setState(() {
            service.cancelNotification(id: 1); //通知をキャンセル
            seconds -=
                backgroundDuration.inSeconds.toDouble(); // バックグラウンド経過時間分時間を進める
          });
          startTimer(); // タイマーを再開する
        }
      }
    }
    /*
    if (_notificationId != null)
      flutterLocalNotificationsPlugin.cancel(_notificationId); // 通知をキャンセル
    _isTimerPaused = false; // リセット
    _notificationId = null; // リセット
    _pausedTime = null;
    */
  }

  //リセット(pomo=trueならポモドーロにリセット)
  void resetTimer() => setState(() {
        if (isPomodoro) {
          //ポモドーロ終了時
          maxseconds = resttime;
          seconds = resttime;
          isPomodoro = false;
          isTimerPaused = false;
        } else {
          //休憩終了時
          maxseconds = pomotime;
          seconds = pomotime;
          isPomodoro = true;
          isTimerPaused = false;
        }
      });

  void startTimer({bool reset = true}) {
    /*
    if (reset) {
      resetTimer();
    }
    */
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      if (seconds > 0) {
        //タイマーが動作中なら
        setState(() {
          seconds = seconds - 0.1;
        });
      } else {
        //カウントが残り０なら止める
        stopTimer(reset: false);
        if (isPomodoro) {
          await service.showNotification(
              id: 0, title: "ポモドーロ終了！", body: "お疲れ様〜", sound: "pomo_end.wav");
        } else {
          await service.showNotification(
              id: 0, title: "休憩終了", body: "もういっちょ頑張ろう", sound: "rest_end.wav");
        }

        resetTimer();
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      //isPomodoro = !isPomodoro; //ポモドーロ反転する
      resetTimer();
    }
    setState(() => timer?.cancel());
    isTimerPaused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              service.cancelNotification(id: 0);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: isPomodoro ? const Text("集中モード") : const Text("休憩モード"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(isPomodoro: isPomodoro),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  /*
  Widget appBarTimer() {
    return Text("a");
  }
  */
  Widget buildButtons() {
    //final isShowing = true; //画面表示を切り替える（isRunningだと１秒のラグがあるため）
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxseconds || seconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                //キャンセルを押すとリセットする
                text: "終了",
                onClicked: stopTimer,
              ),
              const SizedBox(width: 12),
              ButtonWidget(
                text: isRunning ? "停止" : "再開",
                onClicked: () {
                  if (isRunning) {
                    //タイマー動作中ならストップ
                    //pauseButton
                    stopTimer(reset: false);
                  } else {
                    //タイマー中止中ならスタート
                    //resumeButton
                    startTimer(reset: false);
                  }
                },
              ),
            ],
          )
        : ButtonWidget(
            text: 'スタート',
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              service.cancelNotification(id: 1);
              startTimer();
            },
          );
  }

  //タイマーの円
  Widget buildTimer({required bool isPomodoro}) => SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxseconds,
              valueColor: AlwaysStoppedAnimation(
                  isPomodoro ? Colors.orange : Colors.greenAccent),
              strokeWidth: 9,
              backgroundColor: Colors.black12,
            ),
            Center(child: buildTime()),
          ],
        ),
      );

  //timerの文字
  Widget buildTime() {
    return Text(
      //"$seconds",
      "${((seconds.toInt()) / 60).floor().toString().padLeft(2, "0")}:${(seconds.toInt() % 60).toString().padLeft(2, "0")}",
      style: const TextStyle(
        fontWeight: FontWeight.w300,
        fontFeatures: <FontFeature>[
          FontFeature.tabularFigures(),
        ],
        color: Colors.black87,
        fontSize: 55,
      ),
    );
  }
}
