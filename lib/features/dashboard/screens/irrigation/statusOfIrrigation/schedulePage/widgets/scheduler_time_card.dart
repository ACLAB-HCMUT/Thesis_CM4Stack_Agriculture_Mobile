import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../controllers/my_farm_controllers/scheduler_controller/scheduler_controller.dart';

class SchedulerTimeCard extends StatelessWidget {
  final String deviceId;
  SchedulerTimeCard({required this.deviceId});
  final SchedulerController controller = Get.put(SchedulerController());

  String getPumpNumber() {
    return deviceId.split('_').last; // Extract pump number
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set Pump Schedule",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TColors.accent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Configure when your pump turns on and off automatically",
              style: TextStyle(
                fontSize: 14,
                color: TColors.dark,
              ),
            ),
            SizedBox(height: 30),

            // ON time selector
            _buildTimeSelector(
              context,
              icon: Icons.power_settings_new,
              title: "Turn ON at",
              iconColor: TColors.accent,
              timeField: controller.startTime,
              dateField: controller.startDate,
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 24),

            // OFF time selector
            _buildTimeSelector(
              context,
              icon: Icons.power_off,
              title: "Turn OFF at",
              iconColor: TColors.error,
              timeField: controller.endTime,
              dateField: controller.endDate,
            ),

            SizedBox(height: 40),

            // Save button
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Color iconColor,
        required RxString timeField,
        required RxString dateField,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectableField(
                      context,
                      label: "Time",
                      value: timeField,
                      icon: Icons.access_time,
                      onTap: () => controller.pickTime(context, timeField),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildSelectableField(
                      context,
                      label: "Date",
                      value: dateField,
                      icon: Icons.calendar_today,
                      onTap: () => controller.pickDate(context, dateField),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectableField(
      BuildContext context, {
        required String label,
        required RxString value,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return Obx(() {
      final isSelected = value.value != "Select Time" && value.value != "Select Day";
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? TColors.accent.withOpacity(0.1) : TColors.softGrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? TColors.accent : TColors.softGrey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? TColors.accent : TColors.darkerGrey,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  value.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? TColors.accent : TColors.darkerGrey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSaveButton(BuildContext context) {
    return Obx(() {
      final bool isFormComplete = controller.startTime.value != "Select Time" &&
          controller.endTime.value != "Select Time" &&
          controller.startDate.value != "Select Day" &&
          controller.endDate.value != "Select Day";

      return ElevatedButton(
        onPressed: isFormComplete
            ? () {
          _saveSchedule(context);
        }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.white,
          backgroundColor: TColors.accent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(double.infinity, 56),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule),
            SizedBox(width: 8),
            Text(
              "Save Schedule",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _saveSchedule(BuildContext context) {
    // Call the controller to save the schedule
    controller.updateSchedulerOnOff(
      "container_04", // Replace with your actual container ID
      "scheduler_1", // Replace with the scheduler ID (can be dynamic)
      deviceId, // Pass the deviceId dynamically
    );

    // Show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: TColors.accent,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                "Schedule Set Successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your pump will turn ON at:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${controller.startTime.value}, ${controller.startDate.value}"),
              SizedBox(height: 12),
              Text(
                "Your pump will turn OFF at:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${controller.endTime.value}, ${controller.endDate.value}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.isSchedulerSet.value = true;
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: TColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}