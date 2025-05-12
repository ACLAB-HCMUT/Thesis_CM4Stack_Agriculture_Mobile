import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/image_strings.dart';
import 'package:triple_h/utils/constants/sizes.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

import '../../../features/dashboard/controllers/notification_services.dart';
import '../../../features/dashboard/screens/notification/messageDetailScreen.dart';
import '../../../features/dashboard/screens/notification/notifications_list_screen.dart';
import '../../../features/personalization/controllers/user_controller.dart';
import '../../../features/personalization/screens/profile/profile.dart';
import '../../../utils/device/device_utility.dart';
import '../image/circular_image.dart';
import '../shimmers/shimmer_effect.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Icons.search,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Set sizes based on screen dimensions for responsive UI
    final double iconSize = screenWidth * 0.15;
    final double paddingDev = screenWidth * 0.03;
    final controller = Get.put(UserController());
    final dark = THelperFunctions.isDarkMode(context);

    // Get the notification service
    // final notificationService = Get.put(NotificationServices());
    //
    // // Function to handle notification icon tap
    // void handleNotificationTap() {
    //   // If there are notifications, show the most recent one
    //   if (notificationService.notifications.isNotEmpty) {
    //     final latestNotification = notificationService.notifications.first;
    //     Get.to(() => MessageDetailScreen(
    //       title: latestNotification.notification?.title ?? 'Notifications',
    //       body: latestNotification.notification?.body ?? 'Your notifications',
    //       payload: latestNotification.data,
    //     ));
    //   } else {
    //     // If no notifications, show default screen
    //     Get.to(() => const MessageDetailScreen(
    //       title: 'Notifications',
    //       body: 'You have no new notifications',
    //       payload: {'type': 'info', 'message': 'No new notifications'},
    //     ));
    //   }
    //   // Mark as read when accessing notifications
    //   notificationService.markAsRead();
    // }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          height: TDeviceUtils.getScreenHeight() * 0.075,
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.sm),
          decoration: BoxDecoration(
            color: showBackground
                ? (dark ? TColors.dark : TColors.light)
                : Colors.white,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 2, // Spread of the shadow
                blurRadius: 15, // Blur for soft shadow edges
                offset: const Offset(0, 10), // Offset to create floating effect
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth > 600; // Adjust based on desired breakpoint
              return Row(
                mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: [
                  if (isWide) ...[
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                          ? const ShimmerEffect(width: 35, height: 35, radius: 35)
                          : InkWell(
                        onTap: () => Get.to(() => const ProfileScreen()),
                        child: CircularImage(
                          padding: 1.5,
                          image: image,
                          width: 35,
                          height: 35,
                          isNetworkImage: networkImage.isNotEmpty,
                        ),
                      );
                    }),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    // Replace simple IconButton with a Stack for the badge
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigate to notification list screen without directly calling markAsRead
                           // Get.to(() => NotificationsListScreen());
                          },
                          icon: Icon(Icons.notifications, color: TColors.darkGrey),
                        ),
                        // Obx(() => notificationService.unreadCount.value > 0
                        //     ? Positioned(
                        //   right: 0,
                        //   top: 0,
                        //   child: badges.Badge(
                        //     badgeContent: Text(
                        //       //notificationService.unreadCount.value.toString(),
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 10,
                        //       ),
                        //     ),
                        //     badgeStyle: badges.BadgeStyle(
                        //       badgeColor: Colors.red,
                        //       padding: EdgeInsets.all(5),
                        //     ),
                        //   ),
                        // )
                        //     : SizedBox.shrink(),
                        // ),
                      ],
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                  ],

                  Image(image: AssetImage(TImages.searchLogo)),
                  const SizedBox(width: TSizes.spaceBtwItems / 3),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: TColors.companyColor,
                      ),
                    ),
                  ),

                  if (!isWide) ...[
                    IconButton(
                      icon: Icon(icon),
                      color: TColors.darkGrey,
                      onPressed: () {},
                    ),
                    // Replace the notification icon with Stack for badge in mobile view as well
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigate to notification list screen without directly calling markAsRead
                           // Get.to(() => NotificationsListScreen());
                          },
                          icon: Icon(Icons.notifications, color: TColors.darkGrey),
                        ),
                        // Obx(() => notificationService.unreadCount.value > 0
                        //     ? Positioned(
                        //   right: 0,
                        //   top: 0,
                        //   child: badges.Badge(
                        //     badgeContent: Text(
                        //      // notificationService.unreadCount.value.toString(),
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 10,
                        //       ),
                        //     ),
                        //     badgeStyle: badges.BadgeStyle(
                        //       badgeColor: Colors.red,
                        //       padding: EdgeInsets.all(5),
                        //     ),
                        //   ),
                        // )
                        //     : SizedBox.shrink(),
                        // ),
                      ],
                    ),
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                          ? const ShimmerEffect(width: 35, height: 35, radius: 35)
                          : InkWell(
                        onTap: () => Get.to(() => const ProfileScreen()),
                        child: CircularImage(
                          padding: 1.5,
                          image: image,
                          width: 35,
                          height: 35,
                          isNetworkImage: networkImage.isNotEmpty,
                        ),
                      );
                    }),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
