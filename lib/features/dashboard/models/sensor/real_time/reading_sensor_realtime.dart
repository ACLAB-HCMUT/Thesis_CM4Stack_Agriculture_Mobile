// import 'package:firebase_database/firebase_database.dart';
//
// class SensorRealTime {
//   String sensorId;
//   String status;
//   DateTime timestamp;
//   String type;
//   String unit;
//   int value;
//
//   SensorRealTime({
//     required this.sensorId,
//     required this.status,
//     required this.timestamp,
//     required this.type,
//     required this.unit,
//     required this.value,
//   });
//
//   // Factory method to create a SensorRealTime object from a Realtime Database DataSnapshot
//   factory SensorRealTime.fromDataSnapshot(DataSnapshot snapshot) {
//     // Convert _Map<Object?, Object?> to Map<String, dynamic>
//     final data = Map<String, dynamic>.from(
//       (snapshot.value as Map<Object?, Object?>).map((key, value) {
//         return MapEntry(key.toString(), value);
//       }),
//     );
//
//     // Check if data['value'] is a Map, and cast it accordingly
//     final valueMap = data['value'] is Map
//         ? Map<String, dynamic>.from(data['value'])
//         : {};
//
//     return SensorRealTime(
//       sensorId: snapshot.key ?? '',
//       status: valueMap['status'] ?? data['status'] ?? '',  // Fallback to data['status'] if needed
//       timestamp: DateTime.tryParse(valueMap['timestamp'] ?? data['timestamp'] ?? '') ?? DateTime.now(),
//       type: valueMap['type'] ?? data['type'] ?? '',
//       unit: valueMap['unit'] ?? data['unit'] ?? '',
//       value: valueMap['value'] ?? data['value'] ?? 0,  // Handle the integer value directly
//     );
//   }
//
//
//   // Convert a Sensor object to a JSON-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'timestamp': timestamp.toIso8601String(),
//       'type': type,
//       'unit': unit,
//       'value': value,
//     };
//   }
//
//   // Empty Helper Function for initializing an empty Sensor object
//   static SensorRealTime empty() => SensorRealTime(
//     sensorId: '',
//     status: '',
//     timestamp: DateTime.now(),
//     type: '',
//     unit: '',
//     value:0,
//   );
//
//   factory SensorRealTime.fromJson(Map<String, dynamic> json, String sensorId) {
//     return SensorRealTime(
//       sensorId: sensorId,
//       status: json['status'] ?? '',
//       timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
//       type: json['type'] ?? '',
//       unit: json['unit'] ?? '',
//       value: json['value']  ?? 0,
//     );
//   }
// }
import 'package:firebase_database/firebase_database.dart';

// class SensorRealTime {
//   String sensorId;
//   String status;
//   DateTime timestamp;
//   String type;
//   String unit;
//   String value;  // Change the type of value to String
//
//   SensorRealTime({
//     required this.sensorId,
//     required this.status,
//     required this.timestamp,
//     required this.type,
//     required this.unit,
//     required this.value,  // value is now a String
//   });
//
//   // Factory method to create a SensorRealTime object from a Realtime Database DataSnapshot
//   factory SensorRealTime.fromDataSnapshot(DataSnapshot snapshot) {
//     // Convert _Map<Object?, Object?> to Map<String, dynamic>
//     final data = Map<String, dynamic>.from(
//       (snapshot.value as Map<Object?, Object?>).map((key, value) {
//         return MapEntry(key.toString(), value);
//       }),
//     );
//
//     // Check if data['value'] is a Map, and cast it accordingly
//     final valueMap = data['value'] is Map
//         ? Map<String, dynamic>.from(data['value'])
//         : {};
//
//     return SensorRealTime(
//       sensorId: snapshot.key ?? '',
//       status: valueMap['status'] ?? data['status'] ?? '',  // Fallback to data['status'] if needed
//       timestamp: DateTime.tryParse(valueMap['timestamp'] ?? data['timestamp'] ?? '') ?? DateTime.now(),
//       type: valueMap['type'] ?? data['type'] ?? '',
//       unit: valueMap['unit'] ?? data['unit'] ?? '',
//       value: valueMap['value']?.toString() ?? data['value']?.toString() ?? '0',  // Ensure value is a string
//     );
//   }
//
//   // Convert a Sensor object to a JSON-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'timestamp': timestamp.toIso8601String(),
//       'type': type,
//       'unit': unit,
//       'value': value,  // value is now a String
//     };
//   }
//
//   // Empty Helper Function for initializing an empty Sensor object
//   static SensorRealTime empty() => SensorRealTime(
//     sensorId: '',
//     status: '',
//     timestamp: DateTime.now(),
//     type: '',
//     unit: '',
//     value: '0',  // Default value is a String
//   );
//
//   factory SensorRealTime.fromJson(Map<String, dynamic> json, String sensorId) {
//     return SensorRealTime(
//       sensorId: sensorId,
//       status: json['status'] ?? '',
//       timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
//       type: json['type'] ?? '',
//       unit: json['unit'] ?? '',
//       value: json['value']?.toString() ?? '0',  // Ensure value is a string
//     );
//   }
// }
// Abstract base class for all sensors
abstract class SensorRealTime {
  String sensorId;
  String status;
  DateTime timestamp;
  String type;
  String unit;
  String value; // Keep as String for now, parse in subclasses

  SensorRealTime({
    required this.sensorId,
    required this.status,
    required this.timestamp,
    required this.type,
    required this.unit,
    required this.value,
  });

  // Factory method to create the appropriate sensor type based on the snapshot
  factory SensorRealTime.fromDataSnapshot(dynamic snapshot) {
    final data = Map<String, dynamic>.from(
      (snapshot.value as Map<Object?, Object?>).map((key, value) {
        return MapEntry(key.toString(), value);
      }),
    );

    final type = data['type']?.toString().toLowerCase() ?? '';
    print('type ${type}');
    switch (type) {
      case 'soil':
        return SoilSensor.fromDataSnapshot(snapshot);
      case 'temperature':
        return TempSensor.fromDataSnapshot(snapshot);
      case 'humid':
        return HumidSensor.fromDataSnapshot(snapshot);
      default:
        throw Exception('Unknown sensor type: $type');
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'unit': unit,
      'value': value,
    };
  }

  // Empty helper
  static SensorRealTime empty() => SoilSensor.empty(); // Default to SoilSensor for empty
}

// Soil Sensor subclass
class SoilSensor extends SensorRealTime {
  // Thresholds specific to soil
  int maxKaliThreshold;
  int minKaliThreshold;
  int maxNiToThreshold;
  int minNiToThreshold;
  int maxPhosThreshold;
  int minPhosThreshold;

  // Parsed values for K, N, P
  double kaliValue;
  double nitroValue;
  double phosValue;

  SoilSensor({
    required String sensorId,
    required String status,
    required DateTime timestamp,
    required String type,
    required String unit,
    required String value,
    required this.maxKaliThreshold,
    required this.minKaliThreshold,
    required this.maxNiToThreshold,
    required this.minNiToThreshold,
    required this.maxPhosThreshold,
    required this.minPhosThreshold,
  })  : kaliValue = 0,
        nitroValue = 0,
        phosValue = 0,
        super(
        sensorId: sensorId,
        status: status,
        timestamp: timestamp,
        type: type,
        unit: unit,
        value: value,
      ) {
    _parseSoilValue();
  }

  // Parse the soil value string (e.g., "K8,N8,P3")
  void _parseSoilValue() {
    final parts = value.split(',');
    for (var part in parts) {
      if (part.startsWith('K')) {
        kaliValue = double.tryParse(part.replaceFirst('K', '')) ?? 0;
      } else if (part.startsWith('N')) {
        nitroValue = double.tryParse(part.replaceFirst('N', '')) ?? 0;
      } else if (part.startsWith('P')) {
        phosValue = double.tryParse(part.replaceFirst('P', '')) ?? 0;
      }
    }
  }

  factory SoilSensor.fromDataSnapshot(dynamic snapshot) {
    final data = Map<String, dynamic>.from(
      (snapshot.value as Map<Object?, Object?>).map((key, value) {
        return MapEntry(key.toString(), value);
      }),
    );

    return SoilSensor(
      sensorId: snapshot.key ?? '',
      status: data['status']?.toString() ?? '',
      timestamp: DateTime.tryParse(data['timestamp'] ?? '') ?? DateTime.now(),
      type: data['type']?.toString() ?? '',
      unit: data['unit']?.toString() ?? '',
      value: data['value']?.toString() ?? 'K0,N0,P0',
      maxKaliThreshold: int.tryParse(data['maxKaliThreshold']?.toString() ?? '0') ?? 0,
      minKaliThreshold: int.tryParse(data['minKaliThreshold']?.toString() ?? '0') ?? 0,
      maxNiToThreshold: int.tryParse(data['maxNiToThreshold']?.toString() ?? '0') ?? 0,
      minNiToThreshold: int.tryParse(data['minNiToThreshold']?.toString() ?? '0') ?? 0,
      maxPhosThreshold: int.tryParse(data['maxPhosThreshold']?.toString() ?? '0') ?? 0,
      minPhosThreshold: int.tryParse(data['minPhosThreshold']?.toString() ?? '0') ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'maxKaliThreshold': maxKaliThreshold,
      'minKaliThreshold': minKaliThreshold,
      'maxNiToThreshold': maxNiToThreshold,
      'minNiToThreshold': minNiToThreshold,
      'maxPhosThreshold': maxPhosThreshold,
      'minPhosThreshold': minPhosThreshold,
    });
    return json;
  }

  static SoilSensor empty() => SoilSensor(
    sensorId: '',
    status: '',
    timestamp: DateTime.now(),
    type: 'soil',
    unit: 'N/A',
    value: 'K0,N0,P0',
    maxKaliThreshold: 0,
    minKaliThreshold: 0,
    maxNiToThreshold: 0,
    minNiToThreshold: 0,
    maxPhosThreshold: 0,
    minPhosThreshold: 0,
  );
}

// Temperature Sensor subclass
class TempSensor extends SensorRealTime {
  int maxThreshold;
  int minThreshold;
  double tempValue;

  TempSensor({
    required String sensorId,
    required String status,
    required DateTime timestamp,
    required String type,
    required String unit,
    required String value,
    required this.maxThreshold,
    required this.minThreshold,
  })  : tempValue = double.tryParse(value) ?? 0,
        super(
        sensorId: sensorId,
        status: status,
        timestamp: timestamp,
        type: type,
        unit: unit,
        value: value,
      );

  factory TempSensor.fromDataSnapshot(dynamic snapshot) {
    final data = Map<String, dynamic>.from(
      (snapshot.value as Map<Object?, Object?>).map((key, value) {
        return MapEntry(key.toString(), value);
      }),
    );

    return TempSensor(
      sensorId: snapshot.key ?? '',
      status: data['status']?.toString() ?? '',
      timestamp: DateTime.tryParse(data['timestamp'] ?? '') ?? DateTime.now(),
      type: data['type']?.toString() ?? '',
      unit: data['unit']?.toString() ?? '',
      value: data['value']?.toString() ?? '0',
      maxThreshold: int.tryParse(data['maxThreshold']?.toString() ?? '0') ?? 0,
      minThreshold: int.tryParse(data['minThreshold']?.toString() ?? '0') ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'maxThreshold': maxThreshold,
      'minThreshold': minThreshold,
    });
    return json;
  }

  static TempSensor empty() => TempSensor(
    sensorId: '',
    status: '',
    timestamp: DateTime.now(),
    type: 'temperature',
    unit: '°C',
    value: '0',
    maxThreshold: 0,
    minThreshold: 0,
  );
}

// Humidity Sensor subclass
class HumidSensor extends SensorRealTime {
  int maxThreshold;
  int minThreshold;
  double humidValue;

  HumidSensor({
    required String sensorId,
    required String status,
    required DateTime timestamp,
    required String type,
    required String unit,
    required String value,
    required this.maxThreshold,
    required this.minThreshold,
  })  : humidValue = double.tryParse(value) ?? 0,
        super(
        sensorId: sensorId,
        status: status,
        timestamp: timestamp,
        type: type,
        unit: unit,
        value: value,
      );

  factory HumidSensor.fromDataSnapshot(dynamic snapshot) {
    final data = Map<String, dynamic>.from(
      (snapshot.value as Map<Object?, Object?>).map((key, value) {
        return MapEntry(key.toString(), value);
      }),
    );

    return HumidSensor(
      sensorId: snapshot.key ?? '',
      status: data['status']?.toString() ?? '',
      timestamp: DateTime.tryParse(data['timestamp'] ?? '') ?? DateTime.now(),
      type: data['type']?.toString() ?? '',
      unit: data['unit']?.toString() ?? '',
      value: data['value']?.toString() ?? '0',
      maxThreshold: int.tryParse(data['maxThreshold']?.toString() ?? '0') ?? 0,
      minThreshold: int.tryParse(data['minThreshold']?.toString() ?? '0') ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'maxThreshold': maxThreshold,
      'minThreshold': minThreshold,
    });
    return json;
  }

  static HumidSensor empty() => HumidSensor(
    sensorId: '',
    status: '',
    timestamp: DateTime.now(),
    type: 'humid',
    unit: '%',
    value: '0',
    maxThreshold: 0,
    minThreshold: 0,
  );
}