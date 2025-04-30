// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ContainerModel {
//   String containerId;
//   String location;
//   String userId;
//   List<String> sensors;
//   List<String> plantIds;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   ContainerModel({
//     required this.containerId,
//     required this.location,
//     required this.userId,
//     required this.sensors,
//     required this.plantIds,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   // Factory method to create a Container object from Firestore data
//   factory ContainerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     if (data != null) {
//       return ContainerModel(
//         containerId: document.id,
//         location: data['location'] ?? '',
//         userId: data['userId'] ?? '',
//         sensors: List<String>.from(data['sensors'] ?? []),
//         createdAt: (data['createdAt'] as Timestamp).toDate(),
//         updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//         plantIds: List<String>.from(data['plantIds'] ?? []),
//       );
//     } else {
//       return ContainerModel.empty();
//     }
//   }
//
//   factory ContainerModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ContainerModel(
//       containerId: document.id,
//       location: data['location'] ?? '',
//       userId: data['userId'] ?? '',
//       sensors: List<String>.from(data['sensors'] ?? []),
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//       updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//       plantIds: List<String>.from(data['plantIds'] ?? []),
//     );
//   }
//   // Convert a Container object to Firestore-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'location': location,
//       'userId': userId,
//       'sensors': sensors,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'updatedAt': Timestamp.fromDate(updatedAt),
//     };
//   }
//
//   // Empty Helper Function
//   static ContainerModel empty() => ContainerModel(
//     containerId: '',
//     location: '',
//     userId: '',
//     sensors: [],
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//     plantIds: [],
//   );
//
//
// }


//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ContainerModel {
//   String containerId;
//   String name;
//   String location; // Location of the container
//   String userId;
//   List<String> sensors;
//   List<String> outputDevices;
//   double totalArea;
//   String areaUnit;
//   List<String> plantIds; // List of plant IDs in the container
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   ContainerModel({
//     required this.containerId,
//     required this.name,
//     required this.location,
//     required this.userId,
//     required this.sensors,
//     required this.outputDevices,
//     required this.totalArea,
//     required this.areaUnit,
//     required this.plantIds,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   // Factory method to create a ContainerModel object from Firestore data
//   factory ContainerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     if (data != null) {
//       return ContainerModel(
//         containerId: document.id,
//         name: data['name'] ?? '',
//         location: data['location'] ?? '',
//         userId: data['userId'] ?? '',
//         sensors: List<String>.from(data['sensors'] ?? []),
//         outputDevices: List<String>.from(data['outputDevices'] ?? []),
//         totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
//         areaUnit: data['areaUnit'] ?? 'm²',
//         plantIds: List<String>.from(data['plantIds'] ?? []),
//         createdAt: (data['createdAt'] as Timestamp).toDate(),
//         updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//       );
//     } else {
//       return ContainerModel.empty();
//     }
//   }
//
//   // Factory method to create a ContainerModel object from QueryDocumentSnapshot
//   factory ContainerModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ContainerModel(
//       containerId: document.id,
//       name: data['name'] ?? '',
//       location: data['location'] ?? '',
//       userId: data['userId'] ?? '',
//       sensors: List<String>.from(data['sensors'] ?? []),
//       outputDevices: List<String>.from(data['outputDevices'] ?? []),
//       totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
//       areaUnit: data['areaUnit'] ?? 'm²',
//       plantIds: List<String>.from(data['plantIds'] ?? []),
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//       updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//     );
//   }
//
//   // Convert a ContainerModel object to a Firestore-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'location': location,
//       'userId': userId,
//       'sensors': sensors,
//       'outputDevices': outputDevices,
//       'totalArea': totalArea,
//       'areaUnit': areaUnit,
//       'plantIds': plantIds,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'updatedAt': Timestamp.fromDate(updatedAt),
//     };
//   }
//
//   // Empty Helper Function
//   static ContainerModel empty() => ContainerModel(
//     containerId: '',
//     name: '',
//     location: '',
//     userId: '',
//     sensors: [],
//     outputDevices: [],
//     totalArea: 0.0,
//     areaUnit: 'm²',
//     plantIds: [],
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ContainerModel {
//   String containerId;
//   String name;
//   String location; // Location of the container
//   String userId;
//   List<String> sensors;
//   List<String> outputDevices;
//   double totalArea;
//   String areaUnit;
//   List<String> plantIds; // List of plant IDs in the container
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   ContainerModel({
//     required this.containerId,
//     required this.name,
//     required this.location,
//     required this.userId,
//     required this.sensors,
//     required this.outputDevices,
//     required this.totalArea,
//     required this.areaUnit,
//     required this.plantIds,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   // Factory method to create a ContainerModel object from Firestore data
//   factory ContainerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     if (data != null) {
//       return ContainerModel(
//         containerId: document.id,
//         name: data['name'] ?? '',
//         location: data['location'] ?? '',
//         userId: data['userId'] ?? '',
//         sensors: List<String>.from(data['sensors'] ?? []),
//         outputDevices: List<String>.from(data['outputDevices'] ?? []),
//         totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
//         areaUnit: data['areaUnit'] ?? 'm²',
//         plantIds: List<String>.from(data['plantIds'] ?? []),
//         createdAt: (data['createdAt'] as Timestamp).toDate(),
//         updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//       );
//     } else {
//       return ContainerModel.empty();
//     }
//   }
//
//   // Factory method to create a ContainerModel object from QueryDocumentSnapshot
//   factory ContainerModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ContainerModel(
//       containerId: document.id,
//       name: data['name'] ?? '',
//       location: data['location'] ?? '',
//       userId: data['userId'] ?? '',
//       sensors: List<String>.from(data['sensors'] ?? []),
//       outputDevices: List<String>.from(data['outputDevices'] ?? []),
//       totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
//       areaUnit: data['areaUnit'] ?? 'm²',
//       plantIds: List<String>.from(data['plantIds'] ?? []),
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//       updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//     );
//   }
//
//   // Convert a ContainerModel object to a Firestore-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'location': location,
//       'userId': userId,
//       'sensors': sensors,
//       'outputDevices': outputDevices,
//       'totalArea': totalArea,
//       'areaUnit': areaUnit,
//       'plantIds': plantIds,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'updatedAt': Timestamp.fromDate(updatedAt),
//     };
//   }
//
//   // Empty Helper Function
//   static ContainerModel empty() => ContainerModel(
//     containerId: '',
//     name: '',
//     location: '',
//     userId: '',
//     sensors: [],
//     outputDevices: [],
//     totalArea: 0.0,
//     areaUnit: 'm²',
//     plantIds: [],
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ContainerModel {
  String containerId;
  String name;
  String location; // Location of the container
  String userId;
  List<String> sensors;
  List<String> outputDevices;
  double totalArea;
  double remainingArea; // New field for remaining area
  String areaUnit;
  List<String> plantIds; // List of plant IDs in the container
  DateTime createdAt;
  DateTime updatedAt;

  ContainerModel({
    required this.containerId,
    required this.name,
    required this.location,
    required this.userId,
    required this.sensors,
    required this.outputDevices,
    required this.totalArea,
    required this.remainingArea, // Initialize new field
    required this.areaUnit,
    required this.plantIds,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a ContainerModel object from Firestore data
  factory ContainerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return ContainerModel(
        containerId: document.id,
        name: data['name'] ?? '',
        location: data['location'] ?? '',
        userId: data['userId'] ?? '',
        sensors: List<String>.from(data['sensors'] ?? []),
        outputDevices: List<String>.from(data['outputDevices'] ?? []),
        totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
        remainingArea: (data['remainingArea'] as num?)?.toDouble() ?? 0.0, // Parse new field
        areaUnit: data['areaUnit'] ?? 'm²',
        plantIds: List<String>.from(data['plantIds'] ?? []),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      );
    } else {
      return ContainerModel.empty();
    }
  }

  // Factory method to create a ContainerModel object from QueryDocumentSnapshot
  factory ContainerModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ContainerModel(
      containerId: document.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      userId: data['userId'] ?? '',
      sensors: List<String>.from(data['sensors'] ?? []),
      outputDevices: List<String>.from(data['outputDevices'] ?? []),
      totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
      remainingArea: (data['remainingArea'] as num?)?.toDouble() ?? 0.0, // Parse new field
      areaUnit: data['areaUnit'] ?? 'm²',
      plantIds: List<String>.from(data['plantIds'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert a ContainerModel object to a Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'userId': userId,
      'sensors': sensors,
      'outputDevices': outputDevices,
      'totalArea': totalArea,
      'remainingArea': remainingArea, // Add new field to JSON
      'areaUnit': areaUnit,
      'plantIds': plantIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Empty Helper Function
  static ContainerModel empty() => ContainerModel(
    containerId: '',
    name: '',
    location: '',
    userId: '',
    sensors: [],
    outputDevices: [],
    totalArea: 0.0,
    remainingArea: 0.0, // Initialize new field
    areaUnit: 'm²',
    plantIds: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}