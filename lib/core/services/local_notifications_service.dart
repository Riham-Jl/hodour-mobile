import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart';


class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? body, String? payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.id != null) {
          Map data ={};
          List sPayload = details.payload!.split(" ");
          data['notification_id'] = details.id;
          data['course_id'] = sPayload[0]!=null? int.parse(sPayload[0]):null;
          data['type'] = sPayload[1];

            onOpenMessage(data);
          }

      },
    );

    await _createNotificationChannel(
        '0', 'تنبيهات التفقد', '');
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _selectNotification(String? payload) {}
  void deleteAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> show(
      RemoteMessage notification,String? courseId,String? type,String notificationId) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      '1',
      'main',
      channelDescription: 'main channel',
      playSound: true,
      ongoing: true,
      priority: Priority.max,
      importance: Importance.max,
      showProgress: true,
      ticker: 'ticker',
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      int.parse(notificationId),
      notification.notification!.title,
      notification.notification!.body,
      platformChannelSpecifics,
      payload: "$courseId $type",
    );
  }

  Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
      description: description,
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}
