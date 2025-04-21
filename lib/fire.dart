import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pocketcoach/Week%209/notification.dart';

import 'Week 9/pn.dart';
import 'main.dart';

class firebase {
  final _firemess = FirebaseMessaging.instance;
  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );
  final localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _firemess.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initpush();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  Future<void> handlemessage(RemoteMessage? message) async {
    if (message == null) return;
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => pn(),
      ),
    );
  }

  Future<void> initpush() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handlemessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handlemessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;
        localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id, androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@mipmap/ic_launcher'),
          ),
          payload: jsonEncode(message.toMap())
        );
      },
    );
  }
}
