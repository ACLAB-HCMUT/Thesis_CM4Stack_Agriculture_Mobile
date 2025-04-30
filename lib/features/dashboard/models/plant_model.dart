// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PlantModel {
//   String plantId;
//   String name;
//   List<String> category;
//   DateTime datePlanted;
//   String containerId;
//   String imageUrl;
//   List<String> sensors;
//   DateTime createdAt;
//   DateTime updatedAt;
//   DateTime? harvestingDate; // Nullable to account for plants not ready for harvesting
//
//   PlantModel({
//     required this.plantId,
//     required this.name,
//     required this.category,
//     required this.datePlanted,
//     required this.containerId,
//     required this.imageUrl,
//     required this.sensors,
//     required this.createdAt,
//     required this.updatedAt,
//     this.harvestingDate,
//   });
//
//   // Factory method to create a Plant object from Firestore data
//   factory PlantModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     if (data != null) {
//       return PlantModel(
//         plantId: document.id,
//         name: data['name'] ?? '',
//         category: List<String>.from(data['category'] ?? []),
//         datePlanted: (data['datePlanted'] as Timestamp).toDate(),
//         containerId: data['containerId'] ?? '',
//         imageUrl: data['imageUrl'] ?? '',
//         sensors: List<String>.from(data['sensors'] ?? []),
//         createdAt: (data['createdAt'] as Timestamp).toDate(),
//         updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//         harvestingDate: data['harvestingDate'] != null
//             ? (data['harvestingDate'] as Timestamp).toDate()
//             : null,
//       );
//     } else {
//       return PlantModel.empty();
//     }
//   }
//
//   factory PlantModel.fromSnapshotQuery(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     if (data != null) {
//       return PlantModel(
//         plantId: document.id,
//         name: data['name'] ?? '',
//         category: List<String>.from(data['category'] ?? []),
//         datePlanted: (data['datePlanted'] as Timestamp).toDate(),
//         containerId: data['containerId'] ?? '',
//         imageUrl: data['imageUrl'] ?? '',
//         sensors: List<String>.from(data['sensors'] ?? []),
//         createdAt: (data['createdAt'] as Timestamp).toDate(),
//         updatedAt: (data['updatedAt'] as Timestamp).toDate(),
//         harvestingDate: data['harvestingDate'] != null
//             ? (data['harvestingDate'] as Timestamp).toDate()
//             : null,
//       );
//     } else {
//       return PlantModel.empty();
//     }
//   }
//
//   // Convert a Plant object to Firestore-compatible map
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'category': category,
//       'datePlanted': Timestamp.fromDate(datePlanted),
//       'containerId': containerId,
//       'imageUrl': imageUrl,
//       'sensors': sensors,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'updatedAt': Timestamp.fromDate(updatedAt),
//       'harvestingDate': harvestingDate != null ? Timestamp.fromDate(harvestingDate!) : null,
//     };
//   }
//
//   // Empty Helper Function for initializing an empty Plant object
//   static PlantModel empty() => PlantModel(
//     plantId: '',
//     name: '',
//     category: [],
//     datePlanted: DateTime.now(),
//     containerId: '',
//     imageUrl: '',
//     sensors: [],
//     createdAt: DateTime.now(),
//     updatedAt: DateTime.now(),
//   );
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class PlantGroupModel {
  String plantId;
  String plantVariety; // The name of the plant group
  List<String> category; // Categories of plants in this group
  DateTime datePlanted; // Date when the group was planted
  String containerId; // ID of the container where the plant group is located
  String imageUrl; // URL for an uploaded image of the plant group
  List<String> sensors; // Array of sensor IDs monitoring this plant group
  double totalArea; // Total area occupied by the plant group, in square meters
  String nameOfArea; // Name of the area where the plant group is located
  List<String> outputDevices; // Array of output device IDs controlling this plant group
  DateTime createdAt; // Timestamp for when this group was created
  DateTime updatedAt; // Timestamp for the last update to this group
  Map<String, dynamic> thresholds;

  PlantGroupModel({
    required this.plantId,
    required this.plantVariety,
    required this.category,
    required this.datePlanted,
    required this.containerId,
    required this.imageUrl,
    required this.sensors,
    required this.totalArea,
    required this.nameOfArea,
    required this.outputDevices,
    required this.createdAt,
    required this.updatedAt,
    required this.thresholds,
  });
  PlantGroupModel copyWith({
    String? plantId,
    String? plantVariety,
    List<String>? category,
    DateTime? datePlanted,
    String? containerId,
    String? imageUrl,
    List<String>? sensors,
    double? totalArea,
    String? nameOfArea,
    List<String>? outputDevices,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? thresholds,
  }) {
    return PlantGroupModel(
      plantId: plantId ?? this.plantId,
      plantVariety: plantVariety ?? this.plantVariety,
      category: category ?? this.category,
      datePlanted: datePlanted ?? this.datePlanted,
      containerId: containerId ?? this.containerId,
      imageUrl: imageUrl ?? this.imageUrl,
      sensors: sensors ?? this.sensors,
      totalArea: totalArea ?? this.totalArea,
      nameOfArea: nameOfArea ?? this.nameOfArea,
      outputDevices: outputDevices ?? this.outputDevices,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      thresholds: thresholds ?? this.thresholds,
    );
  }
  // Factory method to create a PlantGroupModel object from Firestore data
  factory PlantGroupModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return PlantGroupModel(
        plantId: document.id,
        plantVariety: data['plantVariety'] ?? '',
        category: List<String>.from(data['category'] ?? []),
        datePlanted: (data['datePlanted'] as Timestamp).toDate(),
        containerId: data['containerId'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        sensors: List<String>.from(data['sensors'] ?? []),
        totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
        nameOfArea: data['nameOfArea'] ?? '',
        outputDevices: List<String>.from(data['outputDevices'] ?? []),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        thresholds: Map<String, dynamic>.from(data['thresholds'] ?? {}),
      );
    } else {
      return PlantGroupModel.empty();
    }
  }

  // Factory method to create a PlantGroupModel object from QueryDocumentSnapshot
  factory PlantGroupModel.fromSnapshotQuery(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    if (data != null) {
      return PlantGroupModel(
        plantId: document.id,
        plantVariety: data['plantVariety'] ?? '',
        category: List<String>.from(data['category'] ?? []),
        datePlanted: (data['datePlanted'] as Timestamp).toDate(),
        containerId: data['containerId'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        sensors: List<String>.from(data['sensors'] ?? []),
        totalArea: (data['totalArea'] as num?)?.toDouble() ?? 0.0,
        nameOfArea: data['nameOfArea'] ?? '',
        outputDevices: List<String>.from(data['outputDevices'] ?? []),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        thresholds: Map<String, dynamic>.from(data['thresholds'] ?? {}),
      );
    } else {
      return PlantGroupModel.empty();
    }
  }

  // Convert a PlantGroupModel object to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'plantVariety': plantVariety,
      'category': category,
      'datePlanted': Timestamp.fromDate(datePlanted),
      'containerId': containerId,
      'imageUrl': imageUrl,
      'sensors': sensors,
      'totalArea': totalArea,
      'nameOfArea': nameOfArea,
      'outputDevices': outputDevices,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'thresholds': thresholds
    };
  }

  // Empty Helper Function for initializing an empty PlantGroup object
  static PlantGroupModel empty() => PlantGroupModel(
    plantId: '',
    plantVariety: '',
    category: [],
    datePlanted: DateTime.now(),
    containerId: '',
    imageUrl: '',
    sensors: [],
    totalArea: 0.0,
    nameOfArea: '',
    outputDevices: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    thresholds: {},
  );
}
