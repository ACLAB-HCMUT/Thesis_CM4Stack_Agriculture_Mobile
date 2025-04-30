import 'package:cloud_firestore/cloud_firestore.dart';

import '../sensorData.dart';

class HumiditySensorData extends AbstractSensorData {
  double humidity;
  String unit;

  HumiditySensorData({
    required super.readingId,
    required super.timestamp,
    required this.humidity,
    required this.unit,
  });




  factory HumiditySensorData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return HumiditySensorData(
        readingId: document.id,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        humidity: (data['humidity'] as num).toDouble(),
        unit: data['unit'] ?? '%',
      );
    } else {
      return HumiditySensorData.empty();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'timestamp': Timestamp.fromDate(timestamp),
      'humidity': humidity,
      'unit': unit,
    };
  }

  static HumiditySensorData empty() => HumiditySensorData(
    readingId: '',
    timestamp: DateTime.now(),
    humidity: 0.0,
    unit: '%',
  );

  // HumiditySensorData
  factory HumiditySensorData.fromJson(Map<String, dynamic> json) {
    return HumiditySensorData(
      readingId: json['readingId'] ?? '', // Default to an empty string if not provided
      timestamp: (json['timestamp'] as Timestamp).toDate(), // Convert Firestore timestamp
      humidity: (json['humidity'] as num).toDouble(),
      unit: json['unit'] ?? '%', // Default unit to '%'
    );
  }


}