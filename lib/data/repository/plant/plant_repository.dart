import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/models/plant_model.dart';

class PlantRepository extends GetxController{
  static PlantRepository get instance=>Get.find();
  final _db= FirebaseFirestore.instance;

  Future<List<PlantGroupModel>> fetchPlants(List<String> plantIds) async {
    try {
      // Query the 'plants' collection for documents where the 'plantId' field is in the list of plantIds
      final snapShot = await _db
          .collection('plantGroup')
          .where(FieldPath.documentId, whereIn: plantIds)
          .get();

      return snapShot.docs.map((e) => PlantGroupModel.fromSnapshotQuery(e)).toList();
    } catch (e) {
      throw 'Error fetching plants: $e';
    }
  }
  Future<void> deletePlant(String plantId, String nameOfArea) async {
    try {
      await _db.collection('plantGroup').doc(plantId).delete();

      // delete the plant ID in area
      final areaDocSnapshot = await _db
        .collection('areas')
        .doc(nameOfArea)
        .get();
      if(areaDocSnapshot.exists){
        var areaDoc = areaDocSnapshot.data()!;

        int plantCount = areaDoc['plantCount'] ?? 0;
        int maxPlantGroup = areaDoc['plantCount'] ?? 0;

        // decrease the number of plant
        plantCount--;
        // check the area is available or not
        bool isAvailable = (plantCount < maxPlantGroup) ? true : false;
        List<String> plantIds = List<String>.from(areaDoc['PlantIds'] ?? []);
        plantIds.remove(plantId);

        // update the area document with the new list of plant
        await _db.collection('areas').doc(nameOfArea).update(
          {
            'plantCount' : plantCount,
            'isAvailable': isAvailable,
            'plantIds' : plantIds,
          }
        );
      } else {
        print('No area found with the name: $nameOfArea');
      }
    } catch (e) {
      throw 'Error deleting plant: $e';
    }
  }

  // Method to update thresholds for a plant group
  Future<void> updateThresholds(String plantId, Map<String, dynamic> thresholds) async {
    try {
      await _db.collection('plantGroup').doc(plantId).update({
        'thresholds': thresholds,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e){
      throw 'Error updating Thresholds: $e';
    }
  }
  // Method for threshold -> fetch all plant in the container
  Future<List<PlantGroupModel>> fetchPlantsByContainer(String containerId) async {
    try {
      // Query the 'plantGroup' collection for documents where the 'containerId' field matches
      final snapShot = await _db
          .collection('plantGroup')
          .where('containerId', isEqualTo: containerId)
          .get();

      return snapShot.docs.map((e) => PlantGroupModel.fromSnapshotQuery(e)).toList();
    } catch (e) {
      throw 'Error fetching plants by container: $e';
    }
  }

}