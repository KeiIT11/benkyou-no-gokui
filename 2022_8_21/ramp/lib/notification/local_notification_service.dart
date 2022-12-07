import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

int i = 0; //to count channel.

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/ic_stat_account_box");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails(
      {required String sound}) async {
    //String sound;
    //print(sound.split(".").first);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "channel_id", "channel_name",
      channelDescription: "description",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      //sound: RawResourceAndroidNotificationSound("rest_end"),
      sound: RawResourceAndroidNotificationSound(sound.split(".").first),
      enableVibration: false,
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      sound: sound,
    );

    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("id $id");
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String sound,
  }) async {
    final details = await _notificationDetails(sound: sound);
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
    required String sound,
  }) async {
    final details = await _notificationDetails(sound: sound);
    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          DateTime.now().add(Duration(seconds: seconds)),
          tz.local,
        ),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void onSelectNotification(String? payload) {
    print("payload $payload");
  }

  Future<void> cancelNotification({required int id}) async {
    await _localNotificationService.cancel(id);
  }
}
