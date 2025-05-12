// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:thesis_smart_farm/features/dashboard/models/plant_model.dart';
// import 'package:thesis_smart_farm/features/dashboard/screens/sensor_static/static_sensor.dart';
//
//
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../../styles/shadows.dart';
// import '../containers/rounded_container.dart';
// import '../icons/circular_icon.dart';
// import '../image/rounded_image.dart';
// import '../texts/brand_title_text_with_verfied_con.dart';
// import '../texts/product_price_text.dart';
// import '../texts/product_title_text.dart';
//
// class ProductCardVertical extends StatelessWidget {
//   ProductCardVertical({super.key, required this.plant});
//   PlantModel plant;
//
//   @override
//   Widget build(BuildContext context) {
//     String imageLink=plant.imageUrl;
//     final DateTime createAt=DateTime.parse(plant.createdAt as String).toLocal();
//     final now=DateTime.now();
//     final difference=now.difference(createAt);
//     final dark = THelperFunctions.isDarkMode(context);
//     return GestureDetector(
//       onTap:()=> Get.to(()=>StaticSensorScreen()),
//       child: Container(
//
//         width: 180,
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [ShadowStyle.verticalProductShadow],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? TColors.darkGrey : TColors.white,
//         ),
//         child: Column(
//           children: [
//             //* Thumbnail
//             RoundedContainer(
//               height: 100,
//               backgroundColor: dark ? TColors.dark : TColors.light,
//               shadow: [],
//               child: Stack(
//                 children: [
//                   //* Thumbnail Image
//
//                    RoundedImage(
//                     imageUrl:plant.imageUrl,
//                     applyImageRadius: true,
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems,),
//                   //* sale tag
//
//
//
//
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwItems / 2,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                 Text(
//                 plant.name,
//                 style: TextStyle(
//                   color: TColors.companyColor, // Color for the text
//                   fontSize: TSizes.fontSizeMd,        // Font size for the whole text
//                   fontWeight: FontWeight.bold, // Bold the entire text
//                 ),
//               ),
//                   SizedBox(height: TSizes.spaceBtwItems/2,),
//                   RoundedContainer(
//                     shadow: [],
//                     backgroundColor: Colors.white,
//                     width: THelperFunctions.screenWidth() * 0.3,
//                     height: THelperFunctions.screenHeight() * 0.04,
//                     showBorder: true,
//                     borderColor: Colors.red,
//                     child: Center(
//                       child: Text(
//                         'Healthy',
//                         style: Theme.of(context)
//                             .textTheme
//                             .labelSmall!
//                             .apply(color: TColors.plantStatusColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems/2,),
//
//                   Center(
//                     child: Text(
//                       '$difference',
//                       style: Theme.of(context).textTheme.labelLarge!.apply(
//                         color: Color(0xFF333333),
//                       ).copyWith(
//                         fontWeight: FontWeight.bold, // Add desired font weight here
//                       ),
//                     ),
//                   )
//
//
//
//                 ],
//               ),
//             )
//
//             //* Details
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:thesis_smart_farm/features/dashboard/models/plant_model.dart';
// import 'package:thesis_smart_farm/features/dashboard/screens/sensor_static/static_sensor.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../../styles/shadows.dart';
// import '../containers/rounded_container.dart';
// import '../icons/circular_icon.dart';
// import '../image/rounded_image.dart';
// import '../texts/brand_title_text_with_verfied_con.dart';
// import '../texts/product_price_text.dart';
// import '../texts/product_title_text.dart';
//
// class ProductCardVertical extends StatelessWidget {
//   ProductCardVertical({super.key, required this.plant});
//   final PlantGroupModel plant;
//
//   @override
//   Widget build(BuildContext context) {
//     String imageLink = plant.imageUrl;
//     final DateTime createdAt = plant.createdAt.toLocal();
//     final now = DateTime.now();
//
//     // Calculate the time difference
//     final difference = now.difference(createdAt);
//     int differenceInDays = difference.inDays;
//
//     // Check if there are additional hours; if so, increment the day count by 1
//     if (difference.inHours % 24 != 0) {
//       differenceInDays += 1;
//     }
//
//     final dark = THelperFunctions.isDarkMode(context);
//
//     return GestureDetector(
//       onTap: () => Get.to(() => SensorDetailScreen(containerId: plant.containerId, sensorIds:plant.sensors,)),
//       child: Container(
//         width: 180,
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [ShadowStyle.verticalProductShadow],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? TColors.darkGrey : TColors.white,
//         ),
//         child: Column(
//           children: [
//             //* Thumbnail
//             RoundedContainer(
//               height: 100,
//               backgroundColor: dark ? TColors.dark : TColors.light,
//               shadow: [],
//               child: Stack(
//                 children: [
//                   //* Thumbnail Image
//                   RoundedImage(
//                     imageUrl: plant.imageUrl,
//                     applyImageRadius: true,
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwItems / 2,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     plant.nameOfArea,
//                     style: TextStyle(
//                       color: TColors.companyColor,
//                       fontSize: TSizes.fontSizeMd,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems / 2),
//                   RoundedContainer(
//                     shadow: [],
//                     backgroundColor: Colors.white,
//                     width: THelperFunctions.screenWidth() * 0.3,
//                     height: THelperFunctions.screenHeight() * 0.04,
//                     showBorder: true,
//                     borderColor: Colors.red,
//                     child: Center(
//                       child: Text(
//                         'Healthy',
//                         style: Theme.of(context)
//                             .textTheme
//                             .labelSmall!
//                             .apply(color: TColors.plantStatusColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems / 2),
//                   Center(
//                     child: Text(
//                       '$differenceInDays days ago',
//                       style: Theme.of(context).textTheme.labelLarge!.apply(
//                         color: Color(0xFF333333),
//                       ).copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';

// import 'package:triple_h/features/dashboard/models/plant_model.dart';
// import 'package:triple_h/features/dashboard/screens/sensor_static/static_sensor.dart';

// import '../../../features/dashboard/controllers/my_farm_controllers/plant_controller/plant_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/shadows.dart';
import '../containers/rounded_container.dart';
import '../image/rounded_image.dart';

// class ProductCardVertical extends StatelessWidget {
//   final PlantGroupModel plant;
//   final bool isConditionWarning;
//   ProductCardVertical({super.key, required this.plant, required this.isConditionWarning} );
//   @override
//   Widget build(BuildContext context) {
//     final plantController = Get.find<PlantController>();
//     String imageLink = plant.imageUrl;
//     final DateTime createdAt = plant.createdAt.toLocal();
//     final now = DateTime.now();
//
//     // Calculate the time difference
//     final difference = now.difference(createdAt);
//     int differenceInDays = difference.inDays;
//
//     // Increment the day count by 1 if there are additional hours
//     if (difference.inHours % 24 != 0) {
//       differenceInDays += 1;
//     }
//
//     final dark = THelperFunctions.isDarkMode(context);
//     print(plant.containerId);
//     print(plant.sensors);
//     return GestureDetector(
//       onTap: () => Get.to(() => SensorDetailScreen(
//         // containerId: plant.containerId,
//         // containerId: plant.containerId,
//         containerId: 'container_04',
//         sensorIds: plant.sensors,
//       )),
//       child: Container(
//         width: 180,
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1), // Light black shadow
//               spreadRadius: 2, // Spread of the shadow
//               blurRadius: 10, // Blur effect for a soft shadow
//               offset: const Offset(0, 6), // Vertical offset for floating effect
//             ),
//           ],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? TColors.darkGrey : TColors.white,
//         ),
//         child: Column(
//           children: [
//             //* Thumbnail
//             RoundedContainer(
//               height: 100,
//               margin: EdgeInsets.only(top: 8),
//               backgroundColor: dark ? TColors.dark : TColors.light,
//               shadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 10.0,
//                   offset: Offset(0, 4),
//                 )
//               ],
//               child: Stack(
//                 children: [
//                   //* Thumbnail Image
//                   RoundedImage(
//                     imageUrl: plant.imageUrl,
//                     applyImageRadius: true,
//                   ),
//                   SizedBox(height: TSizes.spaceBtwItems),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwItems / 2,
//             ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Row 1: Name of the tree and condition icon
//               Container(
//                 margin: EdgeInsets.only(left: 4), // Adjust the margin as needed
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       plant.plantVariety, // This part of the text (variable)
//                       style: TextStyle(
//                         color: TColors.accent, // Color for plant.plantVariety
//                         fontSize: TSizes.fontSizeLg,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Icon(
//                       isConditionWarning
//                           ? Icons.warning_amber_rounded
//                           : Icons.check_circle_outline_outlined,
//                       color: isConditionWarning ? Colors.red : Colors.green,
//                       size: TSizes.iconMd,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 6),
//               // Row 2: Area name
//               Row(
//                 children: [
//                   Icon(
//                     Icons.location_on_outlined,
//                     size: TSizes.iconMd,
//                     color: TColors.accent,
//                   ),
//                   SizedBox(width: 4,),
//                   Text(
//                     plant.nameOfArea,
//                       style: TextStyle(
//                         color: TColors.dark, // Color for plant.plantVariety
//                         fontSize: TSizes.fontSizeMd,
//                         fontWeight: FontWeight.bold,
//                       )
//                   ),
//                 ],
//               ),
//               SizedBox(height: 6),
//
//               // Row 3: Day growth
//               Row(
//                 children: [
//                   Icon(Icons.auto_graph_outlined,
//                   color: TColors.accent,
//                     size: TSizes.iconMd,
//                   ),
//                   SizedBox(width: 4,),
//                   Text(
//                     '$differenceInDays days ago',
//                     style: Theme.of(context).textTheme.labelMedium!.apply(
//                       color: const Color(0xFF333333),
//                     ).copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: TSizes.spaceBtwItems / 2),
//
//               // Row 4: Slide to Action widget
//               Transform.scale(
//                 scale: 1, // Change the scale factor to reduce or enlarge the widget
//                 child: SlideAction(
//                   sliderButtonIcon: Icon(
//                       Icons.arrow_forward,
//                       color: TColors.dark,
//                       size: TSizes.iconMd,
//                   ),
//                   onSubmit: () async {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           backgroundColor: Colors.white, // Set background to white
//                           title: Text('Deleting Tree', style: TextStyle(color: Colors.black)),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min, // Makes sure the content only takes as much space as needed
//                             children: [
//                               Lottie.asset(
//                                 TImages.moonWeatherNight, // Your Lottie animation
//                                 fit: BoxFit.fill, // This will ensure the animation scales properly within the dialog
//                                 width: 100, // You can adjust the width as per your need
//                                 height: 100, // You can adjust the height as per your need
//                               ),
//                               SizedBox(height: 20), // Adding space between the animation and the text
//                               Text(
//                                 'This tree have been deleted.',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                     // Trigger the delete action when the user slides the button
//                     await plantController.deletePlant(plant.plantId, plant.nameOfArea);
//                     // Show a dialog to notify the user
//                     // Dismiss the dialog after 3 seconds
//                     Future.delayed(Duration(seconds: 3), () {
//                       Navigator.of(context).pop();
//                     });
//                   },
//                   height: MediaQuery.of(context).size.height * 0.075,
//                   // sliderButtonIconSize: (MediaQuery.of(context).size.width * 0.01) ,
//                   child: Container(
//                     margin: EdgeInsets.only(left: 72),
//                     child: Text(
//                       'Slide To Harvest',
//                       style: TextStyle(
//                         color: TColors.white,
//                         fontSize: TSizes.fontSizeSm - 1,
//                       ),
//                     ),
//                   ),
//                   borderRadius: 24,
//                   animationDuration: Duration(milliseconds: 400),
//                   sliderButtonYOffset: -1,
//                   innerColor: TColors.white,
//                   outerColor: Colors.green[400],
//                 ),
//               )
//             ],
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }
// }
