import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/data/services/database/database_service.dart';

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
      await getDeviceToken();
    }
  }

  // Getting the device's FCM Token....
  Future<void> getDeviceToken() async {
    await messaging.getToken().then((token) async {
      await _db.addFCMToken(token!);
    });
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

  Future<void> sendLocalNotifications(
    String diseaseTitle,
    String? prediction,
    double? probability,
  ) async {
    late final List<String> localNotificationData;

    late final String title;
    late final String body;
    late final String type;

    if (prediction != null) {
      switch (prediction) {
        case 'Positive.':
          title = 'Chronic Disease Prediction';
          body = 'We\'re Sorry! \n\n'
              'Result of your last $diseaseTitle report was "Positive". \n\n'
              'You are advised to consult your doctor for further '
              'evaluation.';
          type = 'chronic-disease-prediction';
          break;

        case 'Negative.':
          title = 'Chronic Disease Prediction';
          body = 'Congratulations! \n\n'
              'Result of your last $diseaseTitle report was "Negative". \n\n'
              'You are advised to eat healthy and exercise regularly to avoid '
              'any future risks.';
          type = 'chronic-disease-prediction';
          break;
      }
    }

    if (probability != null) {
      switch (probability) {
        case < 25.00:
          title = 'General Disease Prediction';
          body = 'Probability of your last $diseaseTitle report was '
              '$probability%. \n\n'
              'You are still advised to follow the precautions to '
              'avoid any future risks.';
          type = 'general-disease-prediction';
          break;

        case > 25.00 && <= 50.00:
          title = 'General Disease Prediction';
          body = 'Probability of your last $diseaseTitle report was '
              '$probability%. \n\n'
              'You are advised to follow the precautions to stay healthy '
              'and check your symptoms regularly.';
          type = 'general-disease-prediction';
          break;

        case > 50.00 && <= 75.00:
          title = 'General Disease Prediction';
          body = 'Probability of your last $diseaseTitle report was below '
              '$probability%. \n\n'
              'You are advised to follow the precautions and consult your '
              'doctor for further evaluation.';
          type = 'general-disease-prediction';
          break;

        default:
          title = 'General Disease Prediction';
          body = 'Probability of your last $diseaseTitle report was '
              '$probability%. \n\n'
              'It is critical! Your must consult your doctor for immediate '
              'evaluation and treatment.';
          type = 'general-disease-prediction';
          break;
      }
    }

    localNotificationData = [
      title,
      body,
      type,
    ];

    await showNotification(null, localNotificationData).then((_) async {
      final createdOn = DateTime.now();

      final Map<String, Object> data = {
        'title': title,
        'body': body,
        'type': type,
        'created-on': createdOn,
      };
      await _db.addNotification(data);
    });
  }
}
