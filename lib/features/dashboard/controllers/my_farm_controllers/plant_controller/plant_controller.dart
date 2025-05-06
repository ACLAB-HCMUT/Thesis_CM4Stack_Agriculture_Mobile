import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/container_controller/container.controller.dart';
import 'package:triple_h/features/dashboard/models/plant_model.dart';

import '../../../../../data/repository/plant/plant_repository.dart';
import '../output_devices_controller/output_devices_controller.dart';

class PlantController extends GetxController {
  PlantController get instance => Get.find();
  final containerController = Get.put(ContainerController());
  final plantRepository = Get.put(PlantRepository());

  RxList<PlantGroupModel> plantList = <PlantGroupModel>[].obs;
  var isLoading=false.obs;
  bool isConditionWarning (double val) {
    return true;
  }
  @override
  void onInit() {
    super.onInit();


    // fetchPlants(containerController.plantIdsList.toList()); // Initial fetch
    ever(containerController.plantIdsList, (List<String> plantIds) {
      if (plantIds.isNotEmpty) {
        fetchPlants(plantIds);
      }
    });
  }

  Future<void> fetchPlants(List<String> plantIds) async {
    isLoading.value = true;
    try {
      final plantModelList = await plantRepository.fetchPlants(plantIds);
      plantList.assignAll(plantModelList); // This ensures a reactive update
      if (plantList.isNotEmpty) {
        // Loop through each plant group in the list
        for (var plant in plantList) {
          print('Plant ID: ${plant.plantId}');
          print('Plant Variety: ${plant.plantVariety}');
          print('Category: ${plant.category}');
          print('Date Planted: ${plant.datePlanted}');
          print('Container ID: ${plant.containerId}');
          print('Image URL: ${plant.imageUrl}');
          print('Sensors: ${plant.sensors}');
          print('Total Area: ${plant.totalArea}');
          print('Name of Area: ${plant.nameOfArea}');
          print('Output Devices: ${plant.outputDevices}');
          print('Created At: ${plant.createdAt}');
          print('Updated At: ${plant.updatedAt}');
          print('Thresholds: ${plant.thresholds}');
          var sensorId = 'tempSensor1';
          var sensorData = plant.thresholds[sensorId];
          print('tempSensor1 thresholds: ${sensorData['min']}');
          print('---'); // Separator between plant groups for readability
        }
      } else {
        print('No plant groups found.');
      }
      plantList.refresh();

    } catch (e) {

    } finally {
      plantList.refresh();
      isLoading.value = false; // Set loading to false after fetching
    }
  }


  Future<List<PlantGroupModel>> fetchPlantsFromDb() async {
    try {
      // Fetch all plant documents in the 'plants' collection
      final snapshot = await FirebaseFirestore.instance.collection('plants').get();
      return snapshot.docs.map((doc) => PlantGroupModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception("Error fetching plants: $e");
    }
  }
  // Delete plant from repository
  Future<void> deletePlant(String plantId, String area) async {
    isLoading.value = true;
    try {
      await plantRepository.deletePlant(plantId, area);
      // After deleting the plant, refresh the list of plants
      plantList.removeWhere((plant) => plant.plantId == plantId);
    } catch (e) {
      print('Error deleting plant: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update thresholds for a specific sensor in a plant
  Future<void> updateSensorThreshold(String plantId, String sensorId, double min, double max, String type) async {
    isLoading.value = true;
    try {
      // Get the current plant to update its thresholds
      final plantIndex = plantList.indexWhere((plant) => plant.plantId == plantId);

      if (plantIndex >= 0) {
        // Create a copy of the current thresholds
        final currentPlant = plantList[plantIndex];
        final Map<String, dynamic> thresholds = Map<String, dynamic>.from(currentPlant.thresholds);

        // Update the specific sensor threshold
        thresholds[sensorId] = {
          'min': min,
          'max': max,
          'type': type,
        };

        // Call repository to update in Firebase
        await plantRepository.updateThresholds(plantId, thresholds);

        // Update the local model
        final updatedPlant = plantList[plantIndex].copyWith(thresholds: thresholds);
        plantList[plantIndex] = updatedPlant;
        plantList.refresh();

        Get.snackbar(
            'Success',
            'Threshold values updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.7),
            colorText: Colors.white
        );
      } else {
        Get.snackbar(
            'Error',
            'Plant not found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white
        );
      }
    } catch (e) {
      Get.snackbar(
          'Error',
          'Failed to update thresholds: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white
      );
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> updateSoilSensorThresholds(String plantId, String sensorId, Map<String, dynamic> soilValues) async {
    isLoading.value = true;
    try {
      // Get the current plant to update its thresholds
      final plantIndex = plantList.indexWhere((plant) => plant.plantId == plantId);

      if (plantIndex >= 0) {
        // Create a copy of the current thresholds
        final currentPlant = plantList[plantIndex];
        final Map<String, dynamic> thresholds = Map<String, dynamic>.from(currentPlant.thresholds);

        // Update the soil sensor threshold with the complete soil values map
        thresholds[sensorId] = soilValues;

        // Call repository to update in Firebase
        await plantRepository.updateThresholds(plantId, thresholds);

        // Update the local model
        final updatedPlant = currentPlant.copyWith(thresholds: thresholds);
        plantList[plantIndex] = updatedPlant;
        plantList.refresh();

        Get.snackbar(
            'Success',
            'Soil sensor thresholds updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.7),
            colorText: Colors.white
        );
      } else {
        Get.snackbar(
            'Error',
            'Plant not found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.7),
            colorText: Colors.white
        );
      }
    } catch (e) {
      Get.snackbar(
          'Error',
          'Failed to update soil sensor thresholds: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white
      );
    } finally {
      isLoading.value = false;
    }
  }
}