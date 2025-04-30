import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/weather_controller/weather_controller.dart';
import 'package:triple_h/utils/constants/sizes.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate sizes for UI elements
    final double iconSize = screenWidth * 0.15;
    final double fontSizeSmall = screenWidth * 0.04;
    final double fontSizeLarge = screenWidth * 0.05;

    return Obx(() {
      // Change background color dynamically based on weather condition
      final String condition = weatherController.weather.value.mainCondition;
      final List<Color> gradientColors = getBackgroundGradient(condition);

      return Container(
        width: screenWidth,
        height: screenHeight * 0.25,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        padding: EdgeInsets.all(screenWidth * 0.085),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 5), // Floating shadow effect
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Row: Weather Icon and City/Temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Lottie Animation for Weather Icon
                SizedBox(
                  height: TSizes.sunIcon -20,  // Set the height of the Lottie icon independently
                  width: TSizes.sunIcon - 20,   // Set the width of the Lottie icon independently
                  child: Lottie.asset(
                    THelperFunctions.getLottieAnimationPath(condition),
                    fit: BoxFit.fill,
                  ),
                ),

                // City Name and Temperature
                Expanded(  // Use Expanded to prevent text from moving based on icon size
                  child: Align(
                    alignment: Alignment.centerRight,  // Ensure text aligns to the right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          weatherController.cityName.value,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: fontSizeLarge,
                          ),
                        ),
                        Text(
                          '${weatherController.weather.value.temperature.round()}° C',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: fontSizeLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),
            // Center: Date and Time
            Container(
              // margin: EdgeInsets.only(top: 2),
              child: Column (
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: TColors.white,
                        size: fontSizeSmall * 1.2,
                      ),
                      SizedBox(width: 6),
                      Text(
                        weatherController.formattedDate.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: fontSizeSmall * 1.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.wb_cloudy_outlined,
                        color: TColors.white,
                        size: fontSizeSmall * 1.2,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        '${condition}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: fontSizeSmall * 1.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    ],
                  ),
                ]
              ),
            ),




          ],
        ),
      );
    });
  }

  // Helper Function: Get Gradient Colors Based on Weather Condition
  List<Color> getBackgroundGradient(String condition) {
    switch (condition.toLowerCase()) {

      default:
        return [Colors.green.shade200, Colors.green.shade600];
    }
  }
}
