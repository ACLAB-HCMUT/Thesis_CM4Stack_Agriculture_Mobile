import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

class CreateNewPlantRepository extends GetxController {
  static CreateNewPlantRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;

  Future<void> createNewTree(
      String areaName,
      String plantVariety,
      String category,
      DateTime datePlanted,
      List<String> sensors,
      List<String> outputDevices,
      ) async {
    try {
      // Step 1: Fetch sensor types efficiently using whereIn
      Map<String, String> sensorTypes = {};
      if (sensors.isNotEmpty) {
        QuerySnapshot sensorSnapshots = await _firestore
            .collection('sensors')
            .where(FieldPath.documentId, whereIn: sensors)
            .get();
        sensorTypes = {
          for (var doc in sensorSnapshots.docs) doc.id: doc['type'] as String
        };
      }

      // Step 2: Construct the thresholds map with default values of 0
      Map<String, dynamic> thresholds = {};
      for (String sensorId in sensors) {
        String? type = sensorTypes[sensorId];
        if (type == 'temperature' || type == 'humidity') {
          thresholds[sensorId] = {
            'type': type,
            'min': 0,
            'max': 0,
          };
        } else if (type == 'soil') {
          thresholds[sensorId] = {
            'type': 'soil',
            'kali': {'min': 0, 'max': 0},
            'nito': {'min': 0, 'max': 0},
            'phospho': {'min': 0, 'max': 0},
          };
        } else {
          // Handle unknown sensor types (optional logging)
          print('Warning: Unknown sensor type for $sensorId');
        }
      }

      // Step 3: Add a new plant document to the "plantGroup" collection
      DocumentReference newPlantRef = _firestore.collection('plantGroup').doc();
      String imageURLs = THelperFunctions.getCategoryImageURL(category);
      await newPlantRef.set({
        'nameOfArea': areaName,
        'plantVariety': plantVariety,
        'datePlanted': datePlanted,
        'category': [category],
        'imageUrl': imageURLs,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'sensors': sensors,
        'outputDevices': outputDevices,
        'thresholds': thresholds, // Include the initialized thresholds
      });

      // Step 4: Update the "areas" collection
      DocumentSnapshot areaSnapshot =
      await _firestore.collection('areas').doc(areaName).get();

      if (!areaSnapshot.exists) {
        throw Exception("Area does not exist.");
      }

      int plantCount = areaSnapshot['plantCount'] ?? 0;
      int maxPlants = areaSnapshot['maxPlantGroup'] ?? 0;
      String containerId = areaSnapshot['container'];

      if (plantCount >= maxPlants && maxPlants > 0) {
        throw Exception('Maximum number of plants reached for this area.');
      }

      await _firestore.collection('areas').doc(areaName).update({
        'plantIds': FieldValue.arrayUnion([newPlantRef.id]),
        'plantCount': plantCount + 1,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (containerId.isNotEmpty) {
        await _firestore.collection('containers').doc(containerId).update({
          'plantIds': FieldValue.arrayUnion([newPlantRef.id]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      if (plantCount + 1 >= maxPlants && maxPlants > 0) {
        await _firestore.collection('areas').doc(areaName).update({
          'isAvailable': false,
        });
      }

      print('New plant added successfully with thresholds initialized');
    } catch (e) {
      print('Error adding new plant: $e');
      throw Exception('Error adding new plant: $e');
    }
  }
}