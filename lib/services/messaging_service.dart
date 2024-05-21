import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/TaskDetailScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/notification/notification_cubit.dart';
import '../utils/constants.dart';


class MessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void _handleMessage(RemoteMessage? message) async {
    if (message == null) {
      return;
    }
    String title = message.notification?.title ?? 'Default Title';
    String body = message.notification?.body ?? 'Default Body';
    await showNotification(title, body, message.data['link'], message.data['type']);
    // Thực hiện các hành động khi người dùng nhấn vào thông báo tại đây.
    String type = message.data['type']!;
    String link = message.data['link']!;

    if (type == 'Task') {
      navigatorKey.currentState!.pushNamed(TaskDetailScreen.routeName, arguments: link);
    } 
    // else if (type == 'TOURNAMENT') {
    //   navigatorKey.currentState!.pushNamed(TournamentDetailScreen.routeName, arguments: link);
    // }
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");

    if (message.notification != null) {
      String title = message.notification?.title ?? 'Default Title';
      String body = message.notification?.body ?? 'Default Body';

      await showNotification(title, body, message.data['link'], message.data['type']);
      _initLocalNotify();
    }
  }

  Future<void> showNotification(String title, String body, String link, String type) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: '$type|$link');
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      setValue(AppConstant.DEVICE_TOKEN, token);
      initPushNotification();
    } else {
      print('No token received');
    }
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final _notificationCubit = NotificationCubit();
    _notificationCubit.getNotifications();
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _initLocalNotify();
      showNotification(message.notification!.title!, message.notification!.body!, message.data['link'], message.data['type']);
    });
  }

  void _initLocalNotify() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (detail) {
      NotificationCubit().getNotifications(pageSize: 1000);
      //xử lý khi click vào thông báo
      String? payload = detail.payload;
      if (payload != null) {
        debugPrint('notification payload: $payload');
        // Thực hiện các hành động khi người dùng nhấn vào thông báo tại đây.
        List<String> parts = payload.split('|');
        String type = parts[0];
        String link = parts[1];

        if (type == 'Task') {
          navigatorKey.currentState!.pushNamed(TaskDetailScreen.routeName, arguments: link);
        } 
        // else if (type == 'TOURNAMENT') {
        //   navigatorKey.currentState!.pushNamed(TournamentDetailScreen.routeName, arguments: link);
        // }
      }
    });

    final value = getIntAsync(AppConstant.NOTI_COUNT);
    setValue(AppConstant.NOTI_COUNT, value + 1);

    // Xử lý trường hợp ứng dụng được mở thông qua một thông báo
    _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((NotificationAppLaunchDetails? details) {
      if (details != null && details.didNotificationLaunchApp) {
        // Xử lý khi ứng dụng được mở thông qua một thông báo
        String? payload = details.notificationResponse?.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
          // Thực hiện các hành động khi người dùng nhấn vào thông báo tại đây.
        }
      }
    });
  }
}
