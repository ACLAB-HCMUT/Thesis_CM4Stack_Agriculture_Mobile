import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/constants/colors.dart';
import '../../../../controllers/my_farm_controllers/scheduler_controller/scheduler_controller.dart';
import 'widgets/scheduler_time_card.dart';

class SchedulerPage extends StatelessWidget {
  final String deviceId;
  SchedulerPage({required this.deviceId});
  final SchedulerController controller = Get.put(SchedulerController());

  String getDeviceNumber() {
    return deviceId.split('_').last; // Extract the number from the device ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar removed as requested
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [TColors.accent.withOpacity(0.05), TColors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  SizedBox(height: 24),

                  // Schedule Card
                  Obx(() => controller.isSchedulerSet.value
                      ? _buildCurrentScheduleCard(context)
                      : SchedulerTimeCard(deviceId: deviceId)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pump ${getDeviceNumber()} Scheduler",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: TColors.accent,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Set when your pump turns on and off automatically",
          style: TextStyle(
            fontSize: 16,
            color: TColors.dark,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentScheduleCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TColors.secondary2, TColors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TColors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Schedule",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TColors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "ACTIVE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TColors.accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // ON time
          _buildScheduleTimeRow(
            "ON",
            Icons.power_settings_new,
            TColors.accent,
            "${controller.startTime.value}, ${controller.startDate.value}",
          ),
          SizedBox(height: 16),

          // OFF time
          _buildScheduleTimeRow(
            "OFF",
            Icons.power_off,
            TColors.error,
            "${controller.endTime.value}, ${controller.endDate.value}",
          ),

          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  controller.isSchedulerSet.value = false;
                },
                icon: Icon(Icons.edit, color: TColors.accent),
                label: Text(
                  "Modify Schedule",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: TColors.accent,
                  ),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    TColors.white.withOpacity(0.8),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTimeRow(
      String label,
      IconData icon,
      Color color,
      String timeText,
      ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pump $label",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: TColors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                timeText,
                style: TextStyle(
                  fontSize: 14,
                  color: TColors.dark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}