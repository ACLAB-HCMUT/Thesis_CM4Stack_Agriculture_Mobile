import 'package:cloud_firestore/cloud_firestore.dart';

class DataHistoricalChart {
  String readingId;
  DateTime timestamp;
  double value;
  String unit;

  DataHistoricalChart({
    required this.readingId,
    required this.timestamp,
    required this.value,
    required this.unit,
  });

  // Factory method to create a Reading object from a Firestore document snapshot
  factory DataHistoricalChart.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return DataHistoricalChart(
        readingId: document.id,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        value: (data['value'] as num).toDouble(),
        unit: data['unit'] ?? '',
      );
    } else {
      return DataHistoricalChart.empty();
    }
  }

  // Convert a Reading object to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'timestamp': Timestamp.fromDate(timestamp),
      'value': value,
      'unit': unit,
    };
  }

  // Empty Helper Function for initializing empty Reading object
  static DataHistoricalChart empty() => DataHistoricalChart(
    readingId: '',
    timestamp: DateTime.now(),
    value: 0.0,
    unit: '',
  );

  factory DataHistoricalChart.fromJson(Map<String,dynamic> documents){
    final data=documents;
    if(data.isEmpty) return DataHistoricalChart.empty();
    return DataHistoricalChart(
      readingId: data['readingId'] ?? '',
      timestamp: data['timestamp'] ?? DateTime.now(),
      value: data['value'] ?? 0.0,
      unit: data['unit'] ?? '',
    );



  }
}