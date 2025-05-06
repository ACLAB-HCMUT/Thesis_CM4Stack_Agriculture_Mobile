import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triple_h/features/dashboard/models/sensor/historical/sensorData/soil/soil.dart';
import 'package:triple_h/features/dashboard/models/sensor/historical/sensorData/temperature/temperature.dart';

import 'humid/humid.dart';

// Abstract base class for all sensor data
abstract class AbstractSensorData {
  String readingId;
  DateTime timestamp;

  AbstractSensorData({
    required this.readingId,
    required this.timestamp,
  });

  // Method to convert a sensor object to a Firestore-compatible map
  Map<String, dynamic> toJson();

  // Factory method to create sensor data from Firestore snapshot
  static AbstractSensorData fromSnapshot(
      String type,
      DocumentSnapshot<Map<String, dynamic>> document,
      ) {
    // Extract the `_source` field from the document data
    final data = document.data();
    if (data == null) {
      throw Exception("The '_source' field is missing or null for type: $type and ID: ${document.id}");
    }

    // Map the `_source` data to the corresponding sensor data model
    switch (type) {
      case 'soil':
        return SoilSensorData(
          readingId: document.id,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          nitrogen: (data['nitrogen'] as num).toDouble(),
          phosphorus: (data['phosphorus'] as num).toDouble(),
          kali: (data['kali'] as num).toDouble(),
          unit: data['unit'] ?? '',
        );
      case 'temperature':
        return TemperatureSensorData(
          readingId: document.id,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          temperature: (data['value'] as num).toDouble(),
          unit: data['unit'] ?? '°C',
        );
      case 'humid':
        return HumiditySensorData(
          readingId: document.id,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          humidity: (data['value'] as num).toDouble(),
          unit: data['unit'] ?? '%',
        );
      default:
        throw Exception('Unsupported sensor type: $type');
    }
  }


  // Helper to create an empty sensor object based on type
  static AbstractSensorData empty(String type) {
    switch (type) {
      case 'soil':
        return SoilSensorData.empty();
      case 'temperature':
        return TemperatureSensorData.empty();
      case 'humidity':
        return HumiditySensorData.empty();
      default:
        throw Exception('Unsupported sensor type: $type');
    }
  }

  static AbstractSensorData fromJson(String type, Map<String, dynamic> json) {
    switch (type) {
      case 'soil':
        return SoilSensorData.fromJson(json);
      case 'temperature':
        return TemperatureSensorData.fromJson(json);
      case 'humidity':
        return HumiditySensorData.fromJson(json);
      default:
        throw Exception('Unsupported sensor type: $type');
    }
  }
}