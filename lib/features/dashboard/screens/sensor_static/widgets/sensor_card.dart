import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triple_h/utils/constants/colors.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/my_farm_controllers/sensor_controller/sensor_historical_data_controller.dart';
import '../../chart/chart_screen.dart';

/// make it responsive
class SensorCardOneValue extends StatelessWidget {
  final String icon;
  final String value;
  final String name;
  final String status;
  final Color backgroundColor;
  final String sensorId;

  SensorCardOneValue({
    Key? key,
    required this.icon,
    required this.value,
    required this.name,
    required this.status,
    required this.backgroundColor,
    required this.sensorId,
  }) : super(key: key);
  final historicalDataController=Get.put(DataHistoricalChartController());
  @override
  Widget build(BuildContext context) {
    print('File: Static sensor -> ${sensorId} and ${name} ');
    // return GestureDetector(
    //   onTap: () async {
    //       await historicalDataController.fetchSensorData(
    //         sensorId ?? '', // Ensure sensorId is not null
    //         name ?? '',    // Ensure type is not null
    //         'day',
    //       );
    //       Get.to(() => RoundedContainerChart(sensorType: name, sensorId: sensorId));
    //   },
    //   child: RoundedContainer(
    //     height: THelperFunctions.screenHeight() * 0.3,
    //     backgroundColor: backgroundColor,
    //     padding: EdgeInsets.all(TSizes.md),
    //     shadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.1),
    //         blurRadius: 8,
    //         offset: Offset(0, 4),
    //       ),
    //     ],
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Replace Positioned with an Image directly or wrap in Align if needed
    //         Align(
    //           alignment: Alignment.topLeft,
    //           child: Image(image: AssetImage(icon)),
    //         ),
    //         Text(
    //           value,
    //           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
    //             fontWeight: FontWeight.w900,
    //           ),
    //         ),
    //         SizedBox(height: TSizes.xs),
    //         Text(
    //           name == 'temperature' ? 'Temp' : name,
    //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //             color: Colors.black,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         Align(
    //           alignment: Alignment.bottomRight,
    //           child: Container(
    //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //             decoration: BoxDecoration(
    //               border: Border.all(color: Colors.black),
    //               borderRadius: BorderRadius.circular(8),
    //             ),
    //             child: Text(
    //               status,
    //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return GestureDetector(
      onTap: () async {
          await historicalDataController.fetchSensorData(
            sensorId ?? '', // Ensure sensorId is not null
            name ?? '',    // Ensure type is not null
            'day',
          );
          Get.to(() => RoundedContainerChart(sensorType: name, sensorId: sensorId));
      },
      child: RoundedContainer(
          height: THelperFunctions.screenHeight() * 0.3,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(TSizes.md),
          shadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
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
                        name == 'humid' ? Icons.water_drop_outlined : Icons.device_thermostat_outlined,
                        size: 32, color: TColors.dark,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        name == 'temperature' ? 'Temp' : name[0].toUpperCase() + name.substring(1),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      value,
                      style:TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                  // Main Sensor Data
                  // Status Label (bordered button)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),

                    child: Text(
                      status,
                      style: TextStyle(
                        color: status == 'warning' ? TColors.error : TColors.dark,
                        fontSize: TSizes.fontSizeSm - 2,
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}