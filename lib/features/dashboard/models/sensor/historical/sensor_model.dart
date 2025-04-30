import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triple_h/features/dashboard/models/sensor/historical/reading_sensor_model.dart';

class Sensor {
  String sensorId;
  String containerId;
  String type;
  String status;
  List<DataHistoricalChart> readings;

  Sensor({
    required this.sensorId,
    required this.containerId,
    required this.type,
    required this.status,
    this.readings = const [],
  });

  // Factory method to create a Sensor object from a Firestore document snapshot
  factory Sensor.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return Sensor(
        sensorId: document.id,
        containerId: data['containerId'] ?? '',
        type: data['type'] ?? '',
        status: data['status'] ?? '',
        readings:(data['readings'] as List<dynamic>).map((e)=>DataHistoricalChart.fromJson(e)).toList(),
      );
    } else {
      return Sensor.empty();
    }
  }

  // Convert a Sensor object to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'containerId': containerId,
      'type': type,
      'status': status,
    };
  }

  // Empty Helper Function for initializing empty Sensor object
  static Sensor empty() => Sensor(
    sensorId: '',
    containerId: '',
    type: '',
    status: '',
  );
}