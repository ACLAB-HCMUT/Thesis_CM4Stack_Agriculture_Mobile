import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/plant_controller/plant_controller.dart';
import 'package:triple_h/features/dashboard/models/plant_model.dart';
import 'package:triple_h/features/dashboard/screens/sensor_static/widgets/sensor_card.dart';
import 'package:triple_h/features/dashboard/screens/sensor_static/widgets/sensor_card_multiple_value.dart';
import 'package:triple_h/features/dashboard/screens/sensor_static/widgets/setting_multiple_threshold.dart';
import 'package:triple_h/features/dashboard/screens/sensor_static/widgets/setting_one_threshold.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/my_farm_controllers/sensor_controller/sensor_historical_data_controller.dart';
import '../../controllers/my_farm_controllers/sensor_controller/sensor_realtime_controller.dart';
import '../../models/sensor/real_time/reading_sensor_realtime.dart';


class SensorDetailScreen extends StatelessWidget {
  final String containerId;
  // final String areaId;
  final List<String> sensorIds;
  final PlantGroupModel plant;

  SensorDetailScreen({required this.containerId, required this.sensorIds, required this.plant});
  final SensorRealtimeController controller = Get.put(
    SensorRealtimeController(),
  );
  final historicalDataController = Get.put(DataHistoricalChartController());
  final PlantController plantController = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    // Load real-time data for each sensor in the list ONLY ONCE
    // Moving this line to initState equivalent in GetX pattern
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.sensorDataMap.isEmpty) {
        print('Loading real-time sensor data');
        controller.loadRealTimeSensorData(containerId, sensorIds);
      }
    });

    print('Threshold value of plant: ${plant.plantVariety} is ${plant.thresholds.values}');
    print('DEBUG: SensorDetailScreen build called');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: TColors.companyColor),
        ),
      ),
      body: Obx(() {
        print('DEBUG: Obx rebuild for sensor values');
        if (controller.sensorDataMap.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(), // Prevent scroll bouncing
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  // Heading 1
                  'Current Value',
                  style: TextStyle(
                    color: TColors.dark,
                    fontSize: TSizes.fontSizeHg,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.lightGrey,
                    border: Border.all(
                      color: TColors.accent,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.99,
                    ),

                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: sensorIds.length,
                      itemBuilder: (context, index) {
                        final sensorId = sensorIds[index];
                        final sensorData = controller.sensorDataMap[sensorId]?.value;

                        // Check if sensorData is null
                        if (sensorData == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        print('File: Static sensor -> ${sensorData.sensorId} and ${sensorData.type} ');

                        // Handle splitting values safely
                        List<String> values = [];
                        if (sensorData.type == 'soil' && sensorData.value != null) {
                          values = sensorData.value.split(',');
                        }

                        return sensorData.type != 'soil'
                            ? SensorCardOneValue(
                          icon: sensorData.type == 'temperature'
                              ? TImages.tempSensorIcon
                              : TImages.humidSensorIcon,
                          value: (sensorData.value ?? 'N/A') +
                              (sensorData.unit ?? ''),
                          name: sensorData.type ?? 'Unknown',
                          status: sensorData.status ?? 'N/A',
                          backgroundColor:
                          getBackgroundColor(sensorData.type ?? ''),
                          sensorId: sensorData.sensorId ?? '',
                        )
                            : SensorCardMultipleValue(
                          icon: TImages.soilSensor,
                          name: sensorData.type ?? 'Unknown',
                          status: sensorData.status ?? 'N/A',
                          backgroundColor:
                          getBackgroundColor(sensorData.type ?? ''),
                          valueKali: values.isNotEmpty
                              ? values[0]?.substring(1) ?? '0'
                              : '0',
                          valueNitro: values.length > 1
                              ? values[1]?.substring(1) ?? '0'
                              : '0',
                          valuePhos: values.length > 2
                              ? values[2]?.substring(1) ?? '0'
                              : '0',
                          sensorId: sensorData.sensorId ?? '',
                        );
                      },
                    ),
                  ),
                ),
                // DEFINE THRESHOLD VALUE
                const SizedBox(height: 16,),
                Text(
                  'Threshold Setting',
                  style: TextStyle(
                    color: TColors.dark,
                    fontSize: TSizes.fontSizeHg,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: plant.sensors.length,
                    itemBuilder: (context, index) {
                      final sensorId = plant.sensors[index];
                      final sensorData = controller.sensorDataMap[sensorId]?.value;
                      if(sensorData == null){
                        return SizedBox.shrink();
                      }
                      final isSoil = sensorData.type == 'soil';
                      final thresholdData = plant.thresholds[sensorId] ?? {};
                      return ExpansionTile(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: Row(
                          children: [
                            Icon(
                              isSoil ? Icons.eco_outlined :
                              (sensorData.type == 'temperature' ?
                              Icons.device_thermostat_outlined : Icons.water_drop_outlined),
                              color: TColors.dark,
                              size: TSizes.iconLg,
                            ),
                            const SizedBox(width: 8,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the left
                                children: [
                                  Text(
                                    sensorData.type[0].toUpperCase() + sensorData.type.substring(1) ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    isSoil ? 'Set thresholds for soil nutrients (Kali, Nito, Phospho)' :
                                    (sensorData.type == 'temperature' ?
                                    'Set humidity thresholds in your environment.' :
                                    'Set temperature thresholds to maintain a safe range'),
                                    style: TextStyle(
                                      fontSize: TSizes.fontSizeXs,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        initiallyExpanded: false,
                        children: [
                          isSoil
                              ? SettingMultipleThreshold(
                            sensorId: sensorId,
                            plantId: plant.plantId,
                            soilValues: plant.thresholds[sensorId],

                          )
                              : SettingThreshold(
                            name: sensorId,
                            minThreshold: (thresholdData['min'] ?? 0).toDouble(),
                            maxThreshold: (thresholdData['max'] ?? 0).toDouble(),
                            plantId: plant.plantId,
                            sensorType: sensorData.type,
                            // containerId: containerId,
                          ),
                        ],
                      );
                    }
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Color getBackgroundColor(String type) {
    switch (type) {
      case "humid":
        return TColors.humidColor;
      case "temperature":
        return TColors.tempColor;
      case "soil":
        return TColors.soilColor;
      default:
        return TColors.plantStatusColor;
    }
  }
}