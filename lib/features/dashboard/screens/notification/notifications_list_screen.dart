// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:triple_h/features/dashboard/screens/notification/messageDetailScreen.dart';
// import 'package:triple_h/utils/constants/colors.dart';
// import '../../controllers/notification_services.dart';
//
// class NotificationsListScreen extends StatefulWidget {
//   NotificationsListScreen({Key? key}) : super(key: key);
//
//   @override
//   _NotificationsListScreenState createState() => _NotificationsListScreenState();
// }
//
// class _NotificationsListScreenState extends State<NotificationsListScreen> {
//   final NotificationServices _notificationService = Get.find<NotificationServices>();
//
//   @override
//   void initState() {
//     super.initState();
//     // Use post-frame callback to mark as read after the build is complete
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _notificationService.markAsRead();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete_sweep),
//             onPressed: () {
//               // Add confirmation dialog
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Clear Notifications'),
//                     content: Text('Are you sure you want to clear all notifications?'),
//                     actions: [
//                       TextButton(
//                         child: Text('Cancel'),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       TextButton(
//                         child: Text('Clear All'),
//                         onPressed: () {
//                           _notificationService.clearNotifications();
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         final notifications = _notificationService.notifications;
//
//         if (notifications.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.notifications_off,
//                   size: 64,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'No notifications yet',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: notifications.length,
//           itemBuilder: (context, index) {
//             // Display notifications in reverse chronological order
//             final notification = notifications[notifications.length - 1 - index];
//             final notificationData = notification.data;
//             final notificationType = notificationData['type'] ?? '';
//
//             // Determine icon based on notification type
//             IconData notificationIcon = Icons.notifications;
//             if (notificationType.contains('temperature')) {
//               notificationIcon = Icons.warning_amber_outlined;
//             } else if (notificationType.contains('humidity')) {
//               notificationIcon = Icons.warning_amber_outlined;
//             }
//
//             // Format timestamp if available
//             String timeText = 'Recent';
//             if (notificationData.containsKey('timestamp')) {
//               try {
//                 final timestamp = int.parse(notificationData['timestamp']);
//                 final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
//                 final now = DateTime.now();
//                 final difference = now.difference(dateTime);
//
//                 if (difference.inMinutes < 60) {
//                   timeText = '${difference.inMinutes} min ago';
//                 } else if (difference.inHours < 24) {
//                   timeText = '${difference.inHours} hours ago';
//                 } else {
//                   timeText = '${difference.inDays} days ago';
//                 }
//               } catch (e) {
//                 print('Error parsing timestamp: $e');
//               }
//             }
//
//             return Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               elevation: 2,
//               color: TColors.white,
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: TColors.warning.withOpacity(0.2),
//                   child: Icon(notificationIcon, color: TColors.warning),
//                 ),
//                 title: Text(
//                   notification.notification?.title ?? 'Notification',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(notification.notification?.body ?? ''),
//                     SizedBox(height: 4),
//                     Text(
//                       timeText,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   // Navigate to detail screen for this notification
//                   Get.to(() => MessageDetailScreen(
//                     title: notification.notification?.title ?? 'Notification',
//                     body: notification.notification?.body ?? '',
//                     payload: notification.data,
//                   ));
//                 },
//                 isThreeLine: true,
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }