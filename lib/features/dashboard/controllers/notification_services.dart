// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:triple_h/features/dashboard/screens/notification/messageDetailScreen.dart';
//
// class NotificationServices extends GetxController {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   final RxList<RemoteMessage> notifications = <RemoteMessage>[].obs;
//   final Rx<bool> isLoading = false.obs;
//   final Rx<String> errorMessage = ''.obs;
//   final List<String> defaultTopics = ['humidity_alerts', 'temperature_alerts'];
//   final RxInt unreadCount = 0.obs;
//   final RxSet<String> readNotificationIds = <String>{}.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initNotifications();
//     loadSavedNotifications();
//   }
//   // Save notifications to local storage for persistence across app restarts
//   void saveNotifications() {
//     try {
//       final notificationsData = notifications.map((msg) => {
//         'id': msg.messageId,
//         'title': msg.notification?.title,
//         'body': msg.notification?.body,
//         'data': msg.data,
//         'sentTime': msg.sentTime?.millisecondsSinceEpoch.toString(),
//       }).toList();
//
//       GetStorage().write('notifications', notificationsData);
//       GetStorage().write('readNotificationIds', readNotificationIds.toList());
//     } catch (e) {
//       print('Error saving notifications: $e');
//     }
//   }
//   // Load saved notifications from local storage
//   void loadSavedNotifications() {
//     try {
//       final savedNotifications = GetStorage().read<List>('notifications');
//       final savedReadIds = GetStorage().read<List>('readNotificationIds');
//
//       if (savedReadIds != null) {
//         readNotificationIds.value = Set<String>.from(savedReadIds.map((id) => id.toString()));
//       }
//
//       // Update unread count after loading read IDs
//       _updateUnreadCount();
//     } catch (e) {
//       print('Error loading notifications: $e');
//     }
//   }
//
//
//   // Add a method to get unread notifications
//   List<RemoteMessage> getUnreadNotifications() {
//     return notifications.where((msg) =>
//     msg.messageId != null && !readNotificationIds.contains(msg.messageId)
//     ).toList();
//   }
//
//   // Update unread count based on read status
//   void _updateUnreadCount() {
//     int count = 0;
//     for (final msg in notifications) {
//       if (msg.messageId != null && !readNotificationIds.contains(msg.messageId)) {
//         count++;
//       }
//     }
//     unreadCount.value = count;
//     print('Updated unread count: ${unreadCount.value}');
//   }
//
//     // Initialize notifications
//   Future<void> initNotifications() async {
//     try {
//       // Request permission
//       await messaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       // Initialize local notifications
//       const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//       const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
//       const InitializationSettings initSettings = InitializationSettings(
//         android: androidSettings,
//         iOS: iosSettings,
//       );
//
//       await flutterLocalNotificationsPlugin.initialize(
//         initSettings,
//         onDidReceiveNotificationResponse: (details) {
//           // Handle notification tap
//           print('Notification tapped: ${details.payload}');
//         },
//       );
//
//       // Create Android notification channel
//       const AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel',
//         'High Importance Notifications',
//         description: 'This channel is used for important notifications.',
//         importance: Importance.max,
//       );
//
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//
//       // Subscribe to default topics automatically
//       await _subscribeToDefaultTopics();
//
//       // Handle foreground messages
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('Received message: ${message.messageId}');
//         // Check if this is a new message (avoid duplicates)
//         if (message.messageId != null &&
//             !notifications.any((n) => n.messageId == message.messageId)) {
//           notifications.add(message);
//           saveNotifications();
//           showNotification(message);
//           _updateUnreadCount(); // Make sure to call this after adding the notification
//           print('New unread count: ${unreadCount.value}');
//         }
//       });
//
//       // Get initial message (app opened from terminated state)
//       final initialMessage = await messaging.getInitialMessage();
//       if (initialMessage != null) {
//         notifications.add(initialMessage);
//       }
//
//       // Handle background message opens
//       FirebaseMessaging.onMessageOpenedApp.listen((message) {
//         handleMessage(message);
//       });
//     } catch (e) {
//       print('Error initializing notifications: $e');
//     }
//   }
//
//   // Private method to subscribe to default topics
//   Future<void> _subscribeToDefaultTopics() async {
//     try {
//       final token = await messaging.getToken();
//       if (token == null) {
//         print('FCM token is null');
//         return;
//       }
//
//       print('FCM Token: $token');
//       print('Subscribing to default topics: $defaultTopics');
//
//       final url = Uri.parse('https://smart-agriculture-fcm-topic-manager.onrender.com/api/subscribe-proxy');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'token': token,
//           'topics': defaultTopics,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         print('Successfully subscribed to default topics: $defaultTopics');
//       } else {
//         print('Failed to subscribe to topics: ${response.body}');
//       }
//     } catch (e) {
//       print('Error subscribing to default topics: $e');
//     }
//   }
//   // Mark all notifications as read
//   void markAsRead() {
//     for (final msg in notifications) {
//       if (msg.messageId != null) {
//         readNotificationIds.add(msg.messageId!);
//       }
//     }
//     unreadCount.value = 0;
//     saveNotifications();
//   }
//   // Mark a specific notification as read
//   void markNotificationAsRead(String? messageId) {
//     if (messageId != null) {
//       readNotificationIds.add(messageId);
//       _updateUnreadCount();
//       saveNotifications();
//     }
//   }
//   // Show local notification
//   void showNotification(RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = notification?.android;
//
//     if (notification != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel',
//             'High Importance Notifications',
//             channelDescription: 'This channel is used for important notifications.',
//             icon: android?.smallIcon ?? '@mipmap/ic_launcher',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//           iOS: const DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         payload: json.encode(message.data),
//       );
//     }
//   }
//   void handleNotificationTap(RemoteMessage message) {
//     // Add to notifications list if not already there
//     if (!notifications.any((n) => n.messageId == message.messageId)) {
//       notifications.add(message);
//     }
//
//     // Navigate to detail screen
//     Get.to(() => MessageDetailScreen(
//       title: message.notification?.title ?? 'No Title',
//       body: message.notification?.body ?? 'No Body',
//       payload: message.data,
//     ));
//   }
//   // Handle message when tapped
//   void handleMessage(RemoteMessage message) {
//     if (message.notification != null) {
//       Get.to(() => MessageDetailScreen(
//         title: message.notification?.title ?? 'No Title',
//         body: message.notification?.body ?? 'No Body',
//         payload: message.data,
//       ));
//
//       // Add to our list if not already there
//       if (!notifications.any((n) => n.messageId == message.messageId)) {
//         notifications.add(message);
//       }
//     }
//   }
//
//   // Clear notifications list
//   void clearNotifications() {
//     notifications.clear();
//     unreadCount.value = 0;
//     readNotificationIds.clear();
//     saveNotifications();
//   }
// }