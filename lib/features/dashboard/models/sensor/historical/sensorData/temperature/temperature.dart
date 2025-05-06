import 'package:cloud_firestore/cloud_firestore.dart';

import '../sensorData.dart';

class TemperatureSensorData extends AbstractSensorData {
  double temperature;
  String unit;

  TemperatureSensorData({
    required String readingId,
    required DateTime timestamp,
    required this.temperature,
    required this.unit,
  }) : super(readingId: readingId, timestamp: timestamp);

  factory TemperatureSensorData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return TemperatureSensorData(
        readingId: document.id,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        temperature: (data['temperature'] as num).toDouble(),
        unit: data['unit'] ?? '°C',
      );
    } else {
      return TemperatureSensorData.empty();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'timestamp': Timestamp.fromDate(timestamp),
      'temperature': temperature,
      'unit': unit,
    };
  }

  static TemperatureSensorData empty() => TemperatureSensorData(
    readingId: '',
    timestamp: DateTime.now(),
    temperature: 0.0,
    unit: '°C',
  );

  factory TemperatureSensorData.fromJson(Map<String, dynamic> json) {
    return TemperatureSensorData(
      readingId: json['readingId'] ?? '', // Default to an empty string if not provided
      timestamp: (json['timestamp'] as Timestamp).toDate(), // Convert Firestore timestamp
      temperature: (json['temperature'] as num).toDouble(),
      unit: json['unit'] ?? '°C', // Default unit to '°C'
    );
  }
}