import 'package:cloud_firestore/cloud_firestore.dart';

class OutputDeviceModel {
  String outputDeviceId;
  String containerId;
  String type; // e.g., "pump", "LED", "valve", "fan"
  String name; // e.g., "Pump 1", "LED Indicator 1"
  String status; // e.g., "active", "inactive"
  List<String>? zone; // Updated to a list of strings to support multiple zones
  String controlMethod; // e.g., "automatic", "manual"
  DateTime latestStartActive; // Timestamp when the device was last activated
  DateTime? endLatestActive; // Timestamp when the device was last deactivated, if applicable
  DateTime createdAt;
  DateTime updatedAt;

  OutputDeviceModel({
    required this.outputDeviceId,
    required this.containerId,
    required this.type,
    required this.name,
    required this.status,
    this.zone, // Optional field
    required this.controlMethod,
    required this.latestStartActive,
    this.endLatestActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an OutputDeviceModel object from Firestore data
  factory OutputDeviceModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return OutputDeviceModel(
        outputDeviceId: document.id,
        containerId: data['containerId'] ?? '',
        type: data['type'] ?? '',
        name: data['name'] ?? '',
        status: data['status'] ?? '',
        zone: (data['zone'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [] , // Convert List<dynamic> to List<String>
        controlMethod: data['controlMethod'] ?? '',
        latestStartActive: (data['latestStartActive'] as Timestamp?)?.toDate() ?? DateTime.now(),
        endLatestActive: (data['endLatestActive'] as Timestamp?)?.toDate(),
        createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    } else {
      return OutputDeviceModel.empty();
    }
  }

  // Factory method to create an OutputDeviceModel object from QueryDocumentSnapshot
  factory OutputDeviceModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return OutputDeviceModel(
      outputDeviceId: document.id,
      containerId: data['containerId'] ?? '',
      type: data['type'] ?? '', 
      name: data['name'] ?? '',
      status: data['status'] ?? '',
      zone: (data['zone'] as List<dynamic>?)?.map((e) => e as String).toList(), // Convert List<dynamic> to List<String>
      controlMethod: data['controlMethod'] ?? '',
      latestStartActive: (data['latestStartActive'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endLatestActive: (data['endLatestActive'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert an OutputDeviceModel object to a Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'containerId': containerId,
      'type': type,
      'name': name,
      'status': status,
      if (zone != null) 'zone': zone, // Include if not null
      'controlMethod': controlMethod,
      'latestStartActive': Timestamp.fromDate(latestStartActive),
      if (endLatestActive != null) 'endLatestActive': Timestamp.fromDate(endLatestActive!),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Empty Helper Function
  static OutputDeviceModel empty() => OutputDeviceModel(
    outputDeviceId: '',
    containerId: '',
    type: '',
    name: '',
    status: '',
    zone: [], // Initialize as an empty list
    controlMethod: '',
    latestStartActive: DateTime.now(),
    endLatestActive: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
