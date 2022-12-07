import 'package:flutter/material.dart';
import 'package:ramp/record/record_view.dart';
import 'package:flutter/scheduler.dart';
import 'package:ramp/schedule/schedule_view.dart';
import 'package:ramp/timer/view/timer_list.dart';
import 'package:ramp/timer/view/timer_view.dart';
import 'package:ramp/tips/tips_view.dart';
//intlを使うときには地域情報の初期化が必要。main()で使う。
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _screens = [
    TipsView(),
    ScheduleView(),
    //RecordView(),
    //TimerView(),
    timerList(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: '勉強法を学ぶ'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: '計画を立てる'),
            /*
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), label: 'record'),
            */
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: '勉強する'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
