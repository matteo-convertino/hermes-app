import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hermes_app/routing/constants.dart';
import 'package:hermes_app/routing/navigation_service.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  final Map<String, dynamic> payload =
      jsonDecode(notificationResponse.payload!);
  payload["id"] = notificationResponse.id;

  NavigationService().navigateTo(
    notificationDetailsRoute,
    arguments: {
      "notification": payload,
      "interesting": notificationResponse.actionId == null
          ? null
          : notificationResponse.actionId == 'interesting_action'
    },
  );
}

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  _showLocalNotification(message);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidNotificationChannel _channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

Future<void> _setupFlutterNotifications() async {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: notificationTapBackground,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}

Future<void> _showLocalNotification(RemoteMessage message) async {
  final notification = message.data;

  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification["group"],
    notification["text"],
    payload: jsonEncode(notification),
    NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id, _channel.name,
        channelDescription: _channel.description,
        // icon: '@mipmap/ic_launcher.png',
        icon: '@mipmap/ic_launcher',
        autoCancel: false,
        // color: const Color(0xff03413e),
        actions: [
          if (notification["is_high"] == "False")
            const AndroidNotificationAction(
              'interesting_action',
              'Interesting',
              showsUserInterface: true,
              cancelNotification: false,
              // contextual: true,
            ),
          const AndroidNotificationAction(
            'not_interesting_action',
            'I don\'t care',
            showsUserInterface: true,
            cancelNotification: false,
          ),
        ],
      ),
    ),
  );
}

Future<void> initFirebaseFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showLocalNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await _setupFlutterNotifications();
}
