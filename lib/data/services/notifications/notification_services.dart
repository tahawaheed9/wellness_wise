import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wellness_wise/data/services/database/database_service.dart';

class NotificationServices {
  final messaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();
  final _db = DatabaseServices();

  // Initializing flutter local notifications to display notifications to
  // the user when the application is in the foreground (in-app)...
  void initializeLocalNotifications(BuildContext context) async {
    final androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await localNotifications.initialize(
      initializationSettings,
    );
  }

  // Initializing the Firebase Messaging to get the notifications
  // from the firebase...
  void initializeFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isAndroid) {
        if (context.mounted) {
          initializeLocalNotifications(context);
        }
        showNotification(message, null);
      }
    });
  }

  // Requesting notification permissions from the user...
  void requestNotificationPermission() async {
    final settings = await messaging.requestPermission(
      // Allows to display notifications to the user...
      alert: true,
      // Allows the device assistant to read notification for user...
      announcement: true,
      // Notification indication on the app icon...
      badge: true,
      // Allows the device to play the notification sound...
      sound: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final deviceToken = await getDeviceToken();
      debugPrint('Device Token: $deviceToken');
    }
  }

  // Getting the device's FCM Token....
  Future<String> getDeviceToken() async {
    final deviceToken = await messaging.getToken();
    return deviceToken!;
  }

  // Displaying the notifications to the user...
  Future<void> showNotification(
    RemoteMessage? message,
    List<String>? localMessage,
  ) async {
    final androidNotificationChannel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'Wellness Wise Notification Channel',
      importance: Importance.max,
    );

    final androidNotificationDetails = AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'Android Notification Channel',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(
      Duration.zero,
      () {
        localNotifications.show(
          0,
          localMessage != null
              ? localMessage[0]
              : message!.notification!.title.toString(),
          localMessage != null
              ? localMessage[1]
              : message!.notification!.body.toString(),
          notificationDetails,
        );
      },
    );
  }

  Future<void> sendLocalNotifications(String prediction) async {
    late final List<String> localNotificationData;

    late final String title;
    late final String body;
    late final String type;

    if (prediction == 'Positive.') {
      title = 'We\'re Sorry!';
      body = 'Result of your last prediction was "Positive". '
          'You are advised to consult your doctor for further evaluation.';
      type = 'health-prediction';

      localNotificationData = [
        title,
        body,
        type,
      ];
    } else {
      title = 'Congratulations!';
      body = 'Result of your last prediction was "Negative". '
          'You are advised to eat healthy and exercise regularly.';
      type = 'health-prediction';

      localNotificationData = [
        title,
        body,
        type,
      ];
    }
    await showNotification(null, localNotificationData);

    final Map<String, Object> data = {
      'title': title,
      'body': body,
      'type': type,
    };
    await _db.addNotification(data);
  }
}
