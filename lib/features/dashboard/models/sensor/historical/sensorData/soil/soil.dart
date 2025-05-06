import 'package:cloud_firestore/cloud_firestore.dart';

import '../sensorData.dart';

class SoilSensorData extends AbstractSensorData {
  double nitrogen;
  double phosphorus;
  double kali;
  String unit;

  SoilSensorData({
    required String readingId,
    required DateTime timestamp,
    required this.nitrogen,
    required this.phosphorus,
    required this.kali,
    required this.unit,
  }) : super(readingId: readingId, timestamp: timestamp);

  factory SoilSensorData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return SoilSensorData(
        readingId: document.id,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        nitrogen: (data['nitrogen'] as num).toDouble(),
        phosphorus: (data['phosphorus'] as num).toDouble(),
        kali: (data['kali'] as num).toDouble(),
        unit: data['unit'] ?? '',
      );
    } else {
      return SoilSensorData.empty();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'timestamp': Timestamp.fromDate(timestamp),
      'nitrogen': nitrogen,
      'phosphorus': phosphorus,
      'kali': kali,
      'unit': unit,
    };
  }

  static SoilSensorData empty() => SoilSensorData(
    readingId: '',
    timestamp: DateTime.now(),
    nitrogen: 0.0,
    phosphorus: 0.0,
    kali: 0.0,
    unit: '',
  );
  // SoilSensorData
  factory SoilSensorData.fromJson(Map<String, dynamic> json) {
    return SoilSensorData(
      readingId: json['readingId'] ?? '', // Default to an empty string if not provided
      timestamp: (json['timestamp'] as Timestamp).toDate(), // Convert Firestore timestamp
      nitrogen: (json['nitrogen'] as num).toDouble(),
      phosphorus: (json['phosphorus'] as num).toDouble(),
      kali: (json['kali'] as num).toDouble(),
      unit: json['unit'] ?? '', // Default to an empty string if not provided
    );
  }
}