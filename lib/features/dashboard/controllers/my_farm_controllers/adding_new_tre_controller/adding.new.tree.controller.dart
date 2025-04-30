import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_h/data/repository/areas/area_respository.dart';
import 'package:triple_h/features/dashboard/controllers/my_farm_controllers/container_controller/container.controller.dart';
import 'package:triple_h/features/dashboard/models/area_model.dart';
import 'package:triple_h/utils/popups/fullscreen_loader.dart';
import 'package:triple_h/utils/popups/loaders.dart';
import 'package:collection/collection.dart';
import '../../../../../data/repository/plant/create_new_plant.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/network/network_manager.dart';
import '../output_devices_controller/output_devices_controller.dart';
import '../plant_controller/plant_controller.dart';

class AddingTreeController extends GetxController {
  // handle input text
  var isLoading = false.obs;
  final controllerOutputDevices = Get.find<OutputDevicesController>();

  final plantVariety = TextEditingController();
  final areaName = TextEditingController();
  final totalArea = TextEditingController();

  GlobalKey<FormState> addingPlant = GlobalKey<FormState>();

  // for drop down
  final containerController = Get.find<ContainerController>();
  final plantController = Get.put(PlantController());
  final AreaRepository areaRepository = AreaRepository();
  var items = [''].obs;
  var itemsOutputDevices = [''].obs;
  var selectedItems = <String>[].obs;
  var selectedOutputDevices = <String>[].obs;

  /// handle for category
  var selectedCategory = ''.obs;

  // AREA controlling
  RxList<AreaModel> areasData = <AreaModel>[].obs;
  late AreaModel selectedArea;
  RxString selectedAreaId = "".obs;

  // Fetch area data from repository - have to fetch the list of area in from the container
  Future<void> fetchAllAreaData() async {
    try {
      // Fetch the area data from repository
      List<String> areaIds = ['area_01', 'area_02', 'area_03', 'area_04'];
      for (String areaId in areaIds) {
        AreaModel area = await areaRepository.getAreaData(areaId);
        areasData.add(area);
      }
    } catch (e) {
      print("Error fetching area data: $e");
    }
  }

  // Update selected area
  void selectArea (String areaId, AreaModel area) {
    selectedAreaId.value = areaId;
    selectedArea = area;
    print("The selected area is ${selectedAreaId.value}");
    print("the model of area is: ${area}");
  }
  void updateCategory(String? newValue) {
    selectedCategory.value = newValue ?? '';
  }

  AddingTreeController get instance => Get.find();
  var selectedDate = ''.obs;

  void updateSelectedItems(List<String> values) {
    selectedItems.assignAll(values);
  }

  void updateSelectedOutputDevices(List<String> values) {
    selectedOutputDevices.assignAll(values);
  }

  void removeItem(String value) {
    selectedItems.remove(value);
  }

  void removeOutputDevice(String value) {
    selectedOutputDevices.remove(value);
  }

  @override
  void onInit() {
    super.onInit();
    // items.assignAll(containerController.containerList[0].sensors);
    // itemsOutputDevices.assignAll(containerController.containerList[0].outputDevices);
  }

  // Method to show the date picker and update the selected date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Format the date and update the observable variable
      selectedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> createNewTree() async {
    final addingPlantRepository = Get.put(CreateNewPlantRepository());
    final containerController = Get.find<ContainerController>();
    try {
      // Start loading animation
      FullscreenLoader.openLoadingDialog(
          'Adding new Tree', TImages.loadingNewTree);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'No internet', message: 'Please check your internet connection');
        return;
      }

      // Validate input
      if (!addingPlant.currentState!.validate()) {
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'Fail', message: 'Please input all the fields');
        return;
      }
      if (plantVariety.text.trim().isEmpty) {
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'Fail', message: 'Please input a plant variety');
        return;
      }
      if (selectedAreaId.value.isEmpty) { // Updated validation for area selection
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'Fail', message: 'Please select an area');
        return;
      }
      // if (totalArea.text.trim().isEmpty) {
      //   FullscreenLoader.stopLoadingDialog();
      //   Loaders.errorSnackBar(
      //       title: 'Fail', message: 'Please input the total area');
      //   return;
      // }
      if (selectedDate.value.isEmpty) {
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'Fail', message: 'Please select a date');
        return;
      }
      if (selectedCategory.value.isEmpty) {
        FullscreenLoader.stopLoadingDialog();
        Loaders.errorSnackBar(
            title: 'Fail', message: 'Please select a category');
        return;
      }

      // Get selected area and its associated sensors and devices

      print(selectedArea.devices);
      print(selectedArea.sensors);

      List<String> sensors = selectedArea.sensors;  // Get sensors array
      List<String> devices = selectedArea.devices;  // Get devices array
      // Convert selected date to DateTime
      DateTime selectedDateTime = DateTime.parse(selectedDate.value);
      await addingPlantRepository.createNewTree(
          selectedAreaId.value.toLowerCase(),
          plantVariety.text.trim(),
          selectedCategory.value,
          selectedDateTime,
          sensors,
          devices,
      );

      // Fetch updated information from db
      await containerController.fetchContainers();
      ever(containerController.plantIdsList, (List<String> plantIds) {
        if (plantIds.isNotEmpty) {
          plantController.fetchPlants(plantIds);
        }
      });
      // await containerController.updateRemainingArea(
      //     containerController.containerList[0].containerId,
      //     containerArea - totalAreaValue);

      // Stop loading animation
      FullscreenLoader.stopLoadingDialog();

      Loaders.successSnackBar(
          title: 'Success', message: 'New Tree Added Successfully');
    } catch (e) {
      FullscreenLoader.stopLoadingDialog();
      Get.snackbar('Oh Snap!', e.toString());
      Loaders.errorSnackBar(
          title: 'Fail', message: 'Please input all the fields');
    }
  }
}