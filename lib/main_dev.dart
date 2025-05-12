import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:triple_h/features/dashboard/controllers/notification_services.dart';
import 'package:triple_h/utils/constants/api_constants.dart';
import 'app_dev.dart';
import 'data/repository/authentication/authentication_repository.dart';
import 'features/dashboard/screens/notification/messageDetailScreen.dart';
import 'firebase_options_dev.dart';

// Setup Flutter Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Define notification channel for Android
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

// Function to handle background messages
@pragma('vm:entry-point')
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if(message.notification != null){
    print("Some notification received in background...");
  }
}

// Function to handle FCM message when app is open
// void handleMessage(RemoteMessage message) {
//   if (message.notification != null) {
//     Get.to(() => MessageDetailScreen(
//       title: message.notification?.title ?? 'No Title',
//       body: message.notification?.body ?? 'No Body',
//       payload: message.data,
//     ));
//   }
// }
// void handleNotificationClick(Map<String, dynamic> data) {
//   final String title = data['title'] ?? 'Notification';
//   final String body = data['body'] ?? '';
//
//   // Navigate to notification details
//   Get.to(() => MessageDetailScreen(
//     title: title,
//     body: body,
//     payload: data,
//   ));
// }
Future<void> main() async {
  // TODO : add widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // TODO : init local storage
  await GetStorage.init();

  // TODO : Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // Initialize FCM
  final messaging = FirebaseMessaging.instance;
  //final notificationService = NotificationServices();
  // Request notification permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  // Log if user granted permission
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted notification permission');
  } else {
    print('User declined notification permission');
  }

  // Set up foreground notification presentation options (iOS)
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Subscribe to background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // Initialize local notifications
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  // await flutterLocalNotificationsPlugin.initialize(
  //   initSettings,
  //   onDidReceiveNotificationResponse: (response) {
  //     // Handle notification tap
  //     try {
  //       final payload = jsonDecode(response.payload ?? '{}');
  //       Get.to(() => MessageDetailScreen(
  //         title: payload['title'] ?? 'Notification',
  //         body: payload['body'] ?? '',
  //         payload: payload['data'] ?? {},
  //       ));
  //     } catch (e) {
  //       print('Error processing notification tap: $e');
  //     }
  //   },
  // );

  // Setup Android notification channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Get FCM token
  final fcmToken = await messaging.getToken();
  print('FCM Token: $fcmToken');

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   // Add to notification list if not already there
  //   if (!notificationService.notifications.any((n) => n.messageId == message.messageId)) {
  //     notificationService.notifications.add(message);
  //   }
  //
  //   // Mark this specific notification as read
  //   notificationService.markNotificationAsRead(message.messageId);
  //
  //   // Navigate directly to detail screen for this notification
  //   // Get.to(() => MessageDetailScreen(
  //   //   title: message.notification?.title ?? 'Notification',
  //   //   body: message.notification?.body ?? '',
  //   //   payload: message.data,
  //   // ));
  // });

  Firebase.initializeApp().then((_) async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // App was opened by a notification
      // Wait for app to initialize then navigate
      Future.delayed(Duration(seconds: 1), () {
        // Add to notification list if not already there
        // if (!notificationService.notifications.any((n) => n.messageId == initialMessage.messageId)) {
        //   notificationService.notifications.add(initialMessage);
        // }

        // Mark this specific notification as read
      //  notificationService.markNotificationAsRead(initialMessage.messageId);

        // Navigate directly to detail screen for this notification
        // Get.to(() => MessageDetailScreen(
        //   title: initialMessage.notification?.title ?? 'Notification',
        //   body: initialMessage.notification?.body ?? '',
        //   payload: initialMessage.data,
        // ));
      });
    }
  });
  // Initialize Gemini
  Gemini.init(apiKey: geminiAPIKEy);

  runApp(const MyApp());
}