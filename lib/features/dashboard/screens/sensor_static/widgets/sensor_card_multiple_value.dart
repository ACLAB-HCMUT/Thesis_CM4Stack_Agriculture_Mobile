// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:thesis_smart_farm/utils/constants/image_strings.dart';
// import 'package:thesis_smart_farm/utils/constants/text_strings.dart';
// import 'package:thesis_smart_farm/utils/helpers/helper_functions.dart';
//
// import '../../../../../common/widgets/containers/rounded_container.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../models/sensor/real_time/reading_sensor_realtime.dart';
// import '../../chart/chart_screen.dart';
//
// class SensorCardMultipleValue extends StatelessWidget {
//   final String icon;
//   final String valueKali;
//   final String valueNitro;
//   final String valuePhos;
//   final String name;
//   final String status;
//   final Color backgroundColor;
//   final String sensorId;
//
//
//
//   SensorCardMultipleValue({
//
//     Key? key,
//     required this.icon,
//     required this.name,
//     required this.status,
//     required this.backgroundColor, required this.valueKali, required this.valueNitro, required this.valuePhos, required this.sensorId,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RoundedContainer(
//       height: THelperFunctions.screenHeight()*0.3,
//       backgroundColor: backgroundColor,
//       padding: EdgeInsets.all(TSizes.sm),
//       shadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 8,
//           offset: Offset(0, 4),
//         ),
//       ],
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Positioned(child: Image(image: AssetImage(icon))),
//           SizedBox(height: TSizes.sm),
//           Row(
//             children: [
//               Text(
//                 TTexts.sensorNameKali+':',
//                 style: Theme.of(context).textTheme.labelSmall,
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 valueKali,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 TTexts.unitForSoilSensor,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 TTexts.sensorNameNitrogen+':',
//                 style: Theme.of(context).textTheme.labelLarge,
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 valueNitro,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 TTexts.unitForSoilSensor,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//
//
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 TTexts.sensorNamePhosphorus+':',
//                 style: Theme.of(context).textTheme.labelSmall,
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 valuePhos,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(width: TSizes.xs),
//               Text(
//                 TTexts.unitForSoilSensor,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ],
//           ),
//
//
//
//           Align(
//             alignment: Alignment.topRight,
//             child: Container(
//
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 status,
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/my_farm_controllers/sensor_controller/sensor_historical_data_controller.dart';
import '../../chart/chart_screen.dart';

/// make it responsive
class SensorCardMultipleValue extends StatelessWidget {
  final String icon;
  final String valueKali;
  final String valueNitro;
  final String valuePhos;
  final String name;
  final String status;
  final Color backgroundColor;
  final String sensorId;

  SensorCardMultipleValue({
    Key? key,
    required this.icon,
    required this.name,
    required this.status,
    required this.backgroundColor,
    required this.valueKali,
    required this.valueNitro,
    required this.valuePhos,
    required this.sensorId,
  }) : super(key: key);
  final historicalDataController=Get.put(DataHistoricalChartController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        historicalDataController.fetchSensorData(sensorId, name, 'day');
        Get.to(() => RoundedContainerChart(sensorType: name, sensorId: sensorId));
      },
      child: RoundedContainer(
        height: THelperFunctions.screenHeight() * 0.3,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(TSizes.md),
        shadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        // child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // Replace Positioned with an Image directly or wrap in Align if needed
        //     Align(
        //       alignment: Alignment.topLeft,
        //       child: Image(image: AssetImage(icon)),
        //     ),
        //     SizedBox(height: TSizes.sm),
        //     Row(
        //       children: [
        //         Text(
        //           TTexts.sensorNameKali + ':',
        //           style: Theme.of(context).textTheme.labelSmall,
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           valueKali,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           TTexts.unitForSoilSensor,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Text(
        //           TTexts.sensorNameNitrogen + ':',
        //           style: Theme.of(context).textTheme.labelLarge,
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           valueNitro,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           TTexts.unitForSoilSensor,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Text(
        //           TTexts.sensorNamePhosphorus + ':',
        //           style: Theme.of(context).textTheme.labelSmall,
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           valuePhos,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //         SizedBox(width: TSizes.xs),
        //         Text(
        //           TTexts.unitForSoilSensor,
        //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Align(
        //       alignment: Alignment.topRight,
        //       child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.black),
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //         child: Text(
        //           status,
        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon, Label, and Status Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and Label
                Row(
                  children: [
                    Icon(
                      Icons.eco_outlined,
                      size: 32, color: TColors.dark,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      name[0].toUpperCase() + name.substring(1),
                      style: TextStyle(
                        fontSize: TSizes.fontSizeLg,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Status Indicator (small black circle)

                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: TColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,), // Pushes the bottom row to the lower part of the card
            // Bottom Row: Main Sensor Data and Status Label
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    'K: ${valueKali} PPM' ,
                    style:TextStyle(
                      fontSize: TSizes.fontSizeMd - 4,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    'N: ${valueNitro} PPM' ,
                    style:TextStyle(
                      fontSize: TSizes.fontSizeMd - 4,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6),
                  child: Text(
                    'P: ${valuePhos} PPM' ,
                    style:TextStyle(
                      fontSize: TSizes.fontSizeMd - 4 ,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                      status,
                      style: TextStyle(
                        color: TColors.dark,
                        fontSize: TSizes.fontSizeSm - 2,
                      ),
                  ),
                ),

                ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 8),
            //
            //       child: Text(
            //           status,
            //           style: TextStyle(
            //             color: TColors.dark,
            //             fontSize: TSizes.fontSizeSm - 2,
            //           )
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}