import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:triple_h/features/dashboard/models/output_devices_model.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/my_farm_controllers/output_devices_controller/output_devices_controller.dart';
import '../schedulePage/scheduler.dart';

class IrrigationCard extends StatelessWidget {
   IrrigationCard({super.key, required this.outputDeviceModel});

  final OutputDeviceModel outputDeviceModel;

  @override
  Widget build(BuildContext context) {
    final outputDevicesController=Get.find<OutputDevicesController>();
    final dark = THelperFunctions.isDarkMode(context); // Detect dark mode

    // Width for the switch and scheduler button
    final double buttonWidth = THelperFunctions.screenWidth() * 0.35;

    return GestureDetector(
      onTap: () {
        // Add feedback on tap, e.g., navigate or show more details
      },
      child: RoundedContainer(
        margin: const EdgeInsets.all(TSizes.defaultSpace),
        width: double.infinity,
        height: THelperFunctions.screenHeight() * 0.35, // Adjust height for better spacing
        padding: const EdgeInsets.all(16),
        shadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        // Apply the gradient background
        gradient: LinearGradient(
          colors: [
            Colors.green.shade200, // Start color
            Colors.green.shade50, // End color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Zone Display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade100, // Zone background color
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Zone: Vegetable', // Zone display
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8), // Spacing between zone and content

            // Middle Section: Main Content
            Expanded(
              child: Row(
                children: [
                  // Left Section: Device Icon and Name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Image(
                        image: AssetImage(TImages.pump),
                        width: THelperFunctions.screenWidth() * 0.2,
                        height: THelperFunctions.screenHeight() * 0.12,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: THelperFunctions.screenWidth() * 0.1, // Space between columns
                  ),
                  // Right Section: Switch, Scheduler Button, and Mode Text
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Switch
                        LiteRollingSwitch(
                          width: 120,
                          textOn: 'ON',
                          textOff: 'OFF',
                          colorOn: Colors.green,
                          colorOff: Colors.red,
                          iconOn: Icons.check_circle,
                          iconOff: Icons.cancel,
                          textSize: 14,
                          value: outputDeviceModel.status == "active", // Bind to `status`
                          onChanged: (bool isActive) {

                            // Update the status in the controller
                            outputDevicesController.toggleDeviceState(outputDeviceModel.outputDeviceId, isActive);
                          }, onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
                        ),
                        const SizedBox(height: 12),
                        // Scheduler Button
                        ElevatedButton.icon(
                          onPressed: () {
                            // Add scheduler functionality here
                            Get.to(() => SchedulerPage(deviceId: outputDeviceModel.outputDeviceId));
                          },
                          icon: Icon(
                            Icons.schedule, // Icon inside the button
                            size: 16,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Scheduler',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white, // Button text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(buttonWidth, 48), // Match the width of the switch
                            backgroundColor: Colors.brown.shade300, // New button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Rounded button shape
                            ),
                            elevation: 3, // Subtle shadow effect
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Mode Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.settings,
                              color: dark ? Colors.white70 : Colors.grey[600],
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              outputDeviceModel.controlMethod,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: dark ? Colors.white : Colors.grey[700],
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
