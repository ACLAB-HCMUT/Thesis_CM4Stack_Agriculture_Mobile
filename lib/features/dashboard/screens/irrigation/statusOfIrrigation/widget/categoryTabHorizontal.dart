
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/data/repository/authentication/authentication_repository.dart';
import 'package:triple_h/utils/constants/colors.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../controllers/my_farm_controllers/output_devices_controller/output_devices_controller.dart';
import 'IrrigationCards.dart';

class CategoryTabHorizontal extends StatelessWidget {
  const CategoryTabHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final outputDevicesController = Get.put(OutputDevicesController());

    return Obx(() {
      return outputDevicesController.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(color: TColors.companyColor),
      )
          : ListView.builder(
        physics: const NeverScrollableScrollPhysics(), // Avoid nested scroll issues
        shrinkWrap: true,
        itemCount: outputDevicesController.items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0, // Spacing between cards
            ),
            child: RoundedContainer(
              margin: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 120, // Fixed height for UI consistency
              padding: const EdgeInsets.all(16.0),
              shadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade200, // Start color
                  Colors.green.shade50, // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Row(
                children: [
                  // Left Section: Device Name & Icon
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        outputDevicesController.items[index].name, // Sample device name
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.device_hub, // Placeholder for device icon
                        size: 40,
                        color: Colors.green.shade600,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16), // Spacing between sections
                  // Right Section: Zone & Status + Expand Arrow
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Zone Text
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100, // Zone background
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            outputDevicesController.items[index].zone![0], // Sample zone name
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Mode Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              outputDevicesController.items[index].controlMethod,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Expand Arrow
                        GestureDetector(
                          onTap: () {
                            // Navigate or expand to the larger view
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => IrrigationCard(outputDeviceModel: outputDevicesController.items[index]),
                            );
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down, // Expand arrow icon
                            size: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}