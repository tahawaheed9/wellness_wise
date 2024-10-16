import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/data/services/database/database_service.dart';
import '/business/controller/screen_navigation_controller.dart';

class NotificationServices {
  final messaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();

  // Initializing flutter local notifications to display notifications to
  // the user when the application is in the foreground (in-app)...
  void initializeLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    final androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (_) {
        handleNotification(context, message);
      },
    );
  }

  // Initializing the Firebase Messaging to get the notifications
  // from the firebase...
  void initializeFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        if (context.mounted) {
          initializeLocalNotifications(context, message);
        }
        showNotification(message);
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
  Future<void> showNotification(RemoteMessage message) async {
    final androidNotificationChannel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'Wellness Wise Notifications',
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
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
        );
      },
    );

    // Saving notification to the cloud firestore...
    await saveNotification(message);
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // When the application is terminated / killed...
    if (initialMessage != null) {
      if (context.mounted) {
        handleNotification(context, initialMessage);
      }
      await saveNotification(initialMessage);
    }

    // When the application is in the background...
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (context.mounted) {
        handleNotification(context, message);
      }
      await saveNotification(message);
    });
  }

  // Redirecting the user to the specific screens when notification is clicked...
  void handleNotification(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'general-notification') {
      pushNotificationScreen(context);
    }
  }

  Future<void> saveNotification(RemoteMessage message) async {
    final db = DatabaseServices();

    final notificationTitle = message.notification!.title.toString();
    final notificationBody = message.notification!.body.toString();
    final notificationType = message.data['type'].toString();
    final createdOn = DateTime.now();

    final Map<String, Object> data = {
      'title': notificationTitle,
      'body': notificationBody,
      'type': notificationType,
      'created-on': createdOn,
    };

    await db.addNotification(data);
  }
}
