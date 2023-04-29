import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: IOSInitializationSettings(
              requestSoundPermission: false,
              requestBadgePermission: false,
              requestAlertPermission: false,
            ));

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        /// add functionality
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => NotificationScreen(
        //       receivedNotif: payload,
        //     ),
        //   ),
        // );
      }
    });
  }

  static void display(RemoteMessage message) async {
    RemoteNotification notification = message.notification!;

    // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    try {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              "CHAMP PLAY",
              "CHAMP PLAY",
              channelDescription: "CHAMP PLAY notification channel",
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails()),
        payload: message.data.toString(),
      );
    } on Exception catch (e) {
      // TODO
      // print(e);
    }
  }
}
