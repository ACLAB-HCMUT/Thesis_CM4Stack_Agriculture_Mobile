class AreaModel {
  final String id;
  final String name;
  final int numSensors;
  final int numDevices;
  final int numPlanted;
  final int maxPlanted;
  final bool isAvailable;
  final List<String> devices;
  final List<String> sensors;
  AreaModel({
    required this.id,
    required this.name,
    required this.numSensors,
    required this.numDevices,
    required this.numPlanted,
    required this.isAvailable,
    required this.maxPlanted,
    required this.devices,
    required this.sensors,
  });

  // Factory constructor to create an AreaModel from Firestore data
  factory AreaModel.fromFirestore(String id, Map<String, dynamic> data) {
    return AreaModel(
      id: id,
      name: data['name'] ?? 'Unnamed Area', // Default value for name
      numSensors: data['sensorCount'] ?? 0, // Default value for num_sensors
      numDevices: data['deviceCount'] ?? 0, // Default value for num_devices
      numPlanted: data['plantCount'] ?? 0, // Default value for num_planted
      maxPlanted: data['maxPlantGroup'] ?? 0,
      isAvailable: data['isAvailable'] ?? false,
      devices: List<String>.from(data['devices'] ?? []),
      sensors: List<String>.from(data['sensors'] ?? []),
    );
  }

  // Convert AreaModel to a map for saving to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'num_sensors': numSensors,
      'num_devices': numDevices,
      'num_planted': numPlanted,
      'maxPlantGroup': maxPlanted,
      'isAvailable': isAvailable,
      'devices': devices,
      'sensors': sensors,
    };
  }
}