// import 'package:get/get.dart';
// import '../../../../../data/repository/sensor/real_time_sensor_repository.dart';
// import '../../../models/reading_sensor_realtime.dart';
//
// class SensorRealtimeController extends GetxController {
//   final SensorRealtimeRepository repository=Get.put(SensorRealtimeRepository());
//   Rx<SensorRealTime?> sensorData = Rx<SensorRealTime?>(null);
//
//
//   // Method to load real-time data for a specific sensor in a container
//   void loadRealTimeSensorData(String containerId, String sensorId) {
//     repository.getRealTimeSensorData(containerId, sensorId).listen((data) {
//       sensorData.value = data;
//     });
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/repository/sensor/real_time_sensor_repository.dart';
import '../../../../../data/repository/sensor/sensor_repository.dart';
// import '../../../models/reading_sensor_realtime.dart';
import '../../../models/sensor/real_time/reading_sensor_realtime.dart';


class SensorRealtimeController extends GetxController {
  final SensorRealtimeRepository repository = Get.put(SensorRealtimeRepository());


  // Map to store real-time data for each sensor by sensorId
  var sensorDataMap = <String, Rx<SensorRealTime?>>{}.obs;

  // Method to load real-time data for multiple sensors in a container

  void loadRealTimeSensorData(String areaId, List<String> sensorIds) {
    print('DEBUG: loadRealTimeSensorData called with areaId: $areaId, sensorIds: $sensorIds');
    for (var sensorId in sensorIds) {
      // Initialize each sensorId entry in the map with null data
      sensorDataMap[sensorId] = Rx<SensorRealTime?>(null);

      // Listen to each sensor’s real-time data and update the map
      repository.getRealTimeSensorData(areaId, sensorId).listen(
            (data) {
          sensorDataMap[sensorId]?.value = data;
          print('DEBUG: Updated sensorDataMap for $sensorId');
          // print('--- Sensor Data for $sensorId ---');
          // print('Type: ${data.runtimeType}'); // Confirm the type
          // print('Status: ${data.status}');
          // print('Timestamp: ${data.timestamp}');
          // print('Raw Value: ${data.value}');
          //
          // // Access type-specific fields using type checking
          // if (data is SoilSensor) {
          //   print('Soil Sensor Specific Fields:');
          //   print('  K: ${data.kaliValue}, N: ${data.nitroValue}, P: ${data.phosValue}');
          //   print('  Thresholds: K(${data.minKaliThreshold}-${data.maxKaliThreshold}), '
          //       'N(${data.minNiToThreshold}-${data.maxNiToThreshold}), '
          //       'P(${data.minPhosThreshold}-${data.maxPhosThreshold})');
          // } else if (data is TempSensor) {
          //   print('Temperature Sensor Specific Fields:');
          //   print('  Temperature: ${data.tempValue}°C');
          //   print('  Thresholds: ${data.minTempThreshold}-${data.maxTempThreshold}°C');
          // } else if (data is HumidSensor) {
          //   print('Humidity Sensor Specific Fields:');
          //   print('  Humidity: ${data.humidValue}%');
          //   print('  Thresholds: ${data.minThreshold}-${data.maxThreshold}%');
          // } else {
          //   print('Unknown sensor type: ${data.type}');
          // }
          // print('------------------------');
          sensorDataMap.refresh(); // Notify listeners of the change
        },
      );
    }
  }
  // Method to update threshold values in the database
  // Future<void> updateThresholds(String containerId, String sensorId, double minValue, double maxValue) async {
  //   Map<String, dynamic> updates = {
  //     'minThreshold': minValue,
  //     'maxThreshold': maxValue,
  //   };
  //   try {
  //     await repository.updateThresholds(containerId, sensorId, updates);
  //     print('Thresholds updated for $sensorId');
  //   } catch (e) {
  //     print('Failed to update thresholds: $e');
  //   }
  // }
  @override
  void onClose() {
    super.onClose();
  }
}