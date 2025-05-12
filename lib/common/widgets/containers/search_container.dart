// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:thesis_smart_farm/utils/constants/image_strings.dart';
//
//
// import '../../../features/personalization/controllers/user_controller.dart';
// import '../../../features/personalization/screens/profile/profile.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/device/device_utility.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../image/circular_image.dart';
// import '../shimmers/shimmer_effect.dart';
//
// class SearchContainer extends StatelessWidget {
//   const SearchContainer({
//     super.key,
//     required this.text,
//     this.icon = Iconsax.search_normal,
//     this.showBackground = true,
//     this.showBorder = true,
//     this.onTap,
//     this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//   });
//
//   final String text;
//   final IconData? icon;
//   final bool showBackground, showBorder;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry padding;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserController());
//
//     final dark = THelperFunctions.isDarkMode(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: padding,
//         child: Container(
//           height: TDeviceUtils.getScreenHeight()*0.075,
//           width: TDeviceUtils.getScreenWidth(context),
//           padding: const EdgeInsets.all(TSizes.sm),
//           decoration: BoxDecoration(
//             color: showBackground
//                 ? dark
//                     ? TColors.dark
//                     : TColors.light
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//             border: showBorder ? Border.all(color: TColors.grey) : null,
//           ),
//           child: Row(
//             children: [
//               // Icon(
//               //   icon,
//               //   color: TColors.darkGrey,
//               // ),
//               Image(image: AssetImage(TImages.searchLogo)),
//               const SizedBox(
//                 width: TSizes.spaceBtwItems/3,
//               ),
//               Text(
//                 text,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColors.companyColor),
//               ),
//             //SizedBox(width: TSizes.spaceBtwSections*0.75,),
//               IconButton(
//                 icon: Icon(icon),
//                 color: TColors.darkGrey, onPressed: () {  },
//               ),
//               IconButton(onPressed: (){}, icon: Icon(Iconsax.notification)),
//               //IconButton(onPressed: (){}, icon: Icon(Iconsax.user))
//               Obx(() {
//                 final networkImage = controller.user.value.profilePicture;
//                 final image =
//                 networkImage.isNotEmpty ? networkImage : TImages.user;
//
//                 return controller.imageUploading.value
//                     ? const ShimmerEffect(
//                   width: 35,
//                   height: 35,
//                   radius: 35,
//                 )
//                     : InkWell(
//                       onTap: () => Get.to(() => const ProfileScreen()),
//                       child: CircularImage(
//                                         padding:1.5,
//                                         image: image,
//                                         width: 35,
//                                         height: 35,
//                                         isNetworkImage: networkImage.isNotEmpty,
//                                       ),
//                     );
//               }),
//
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


/////////////responsive
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:thesis_smart_farm/utils/constants/colors.dart';
// import 'package:thesis_smart_farm/utils/constants/image_strings.dart';
// import 'package:thesis_smart_farm/utils/constants/sizes.dart';
// import 'package:thesis_smart_farm/utils/helpers/helper_functions.dart';
//
//
// import '../../../features/personalization/controllers/user_controller.dart';
// import '../../../features/personalization/screens/profile/profile.dart';
// import '../../../utils/device/device_utility.dart';
// import '../image/circular_image.dart';
// import '../shimmers/shimmer_effect.dart';
//
// class SearchContainer extends StatelessWidget {
//   const SearchContainer({
//     super.key,
//     required this.text,
//     this.icon = Icons.search,
//     this.showBackground = true,
//     this.showBorder = true,
//     this.onTap,
//     this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//   });
//
//   final String text;
//   final IconData? icon;
//   final bool showBackground, showBorder;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry padding;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserController());
//     final dark = THelperFunctions.isDarkMode(context);
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: padding,
//         child: Container(
//           height: TDeviceUtils.getScreenHeight() * 0.075,
//           width: TDeviceUtils.getScreenWidth(context),
//           padding: const EdgeInsets.all(TSizes.sm),
//           decoration: BoxDecoration(
//             color: showBackground
//                 ? (dark ? TColors.dark : TColors.light)
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//             border: showBorder ? Border.all(color: TColors.grey) : null,
//           ),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               final bool isWide = constraints.maxWidth > 600; // Adjust based on desired breakpoint
//               return Row(
//                 mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Conditional layout based on available space
//                   if (isWide) ...[
//                     // Display profile picture, notification, and search icon on the left for wide screens
//                     Obx(() {
//                       final networkImage = controller.user.value.profilePicture;
//                       final image = networkImage.isNotEmpty ? networkImage : TImages.user;
//                       return controller.imageUploading.value
//                           ? const ShimmerEffect(width: 35, height: 35, radius: 35)
//                           : InkWell(
//                         onTap: () => Get.to(() => const ProfileScreen()),
//                         child: CircularImage(
//                           padding: 1.5,
//                           image: image,
//                           width: 35,
//                           height: 35,
//                           isNetworkImage: networkImage.isNotEmpty,
//                         ),
//                       );
//                     }),
//                     const SizedBox(width: TSizes.spaceBtwItems / 2),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.notifications, color: TColors.darkGrey),
//                     ),
//                     const SizedBox(width: TSizes.spaceBtwItems / 2),
//                   ],
//
//                   // Search icon and field
//                   Image(image: AssetImage(TImages.searchLogo)),
//                   const SizedBox(width: TSizes.spaceBtwItems / 3),
//                   Expanded(
//                     child: Text(
//                       text,
//                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         color: TColors.companyColor,
//                       ),
//                     ),
//                   ),
//
//                   // Display icons on the right if screen is narrow
//                   if (!isWide) ...[
//                     IconButton(
//                       icon: Icon(icon),
//                       color: TColors.darkGrey,
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.notifications),
//                       color: TColors.darkGrey,
//                     ),
//                     Obx(() {
//                       final networkImage = controller.user.value.profilePicture;
//                       final image = networkImage.isNotEmpty ? networkImage : TImages.user;
//                       return controller.imageUploading.value
//                           ? const ShimmerEffect(width: 35, height: 35, radius: 35)
//                           : InkWell(
//                         onTap: () => Get.to(() => const ProfileScreen()),
//                         child: CircularImage(
//                           padding: 1.5,
//                           image: image,
//                           width: 35,
//                           height: 35,
//                           isNetworkImage: networkImage.isNotEmpty,
//                         ),
//                       );
//                     }),
//                   ],
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/image_strings.dart';
import 'package:triple_h/utils/constants/sizes.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications, color: TColors.darkGrey),
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                      color: TColors.darkGrey,
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
