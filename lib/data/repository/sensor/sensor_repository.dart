import 'package:firebase_database/firebase_database.dart';
import '../../../features/dashboard/models/sensor/real_time/reading_sensor_realtime.dart';

class SensorRealtimeRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Stream<SensorRealTime> getRealTimeSensorData(String containerId, String sensorId) {
    return _database
        .child('containers')
        .child(containerId)
        .child(sensorId)
        .onValue
        .map((event) {
          final sensor = SensorRealTime.fromDataSnapshot(event.snapshot);
          print('Sensor $sensorId created as type: ${sensor.runtimeType}'); // Log the type
          return sensor;
    });
  }
}