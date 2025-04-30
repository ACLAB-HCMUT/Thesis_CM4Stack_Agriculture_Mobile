import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/models/container_model.dart';
import 'package:triple_h/features/personalization/controllers/user_controller.dart';

import '../../../../../data/repository/container/container_repository.dart';
import '../../../../../data/repository/user/user_repository.dart';
import '../output_devices_controller/output_devices_controller.dart';

class ContainerController extends GetxController{
  ContainerController get instance=>Get.find();
  final containerRepository=Get.put(ContainerRepository());
  RxList<ContainerModel> containerList=<ContainerModel>[].obs;
  final userRepository= Get.put(UserRepository());
  RxList<String> plantIdsList=<String>[].obs;
  RxString containerId=''.obs;
  var isLoading=false.obs;


  @override
  void onInit() {
    fetchContainers();
    super.onInit();

  }
  Future<void> fetchContainers() async {
    try {
      isLoading.value = true; // Set loading to true at the start
      // Fetch user details and containers
      final usersInfo = await userRepository.fetchUserDetails();
      final containers = await containerRepository.fetchContainers(usersInfo.containers);

      // Update container list and other related data
      containerList.assignAll(containers);
      if (containerList.isNotEmpty) {
        containerId = containerList[0].containerId.obs;
        plantIdsList.assignAll(containerList[0].plantIds);
      } else {
        print("No containers available for this user.");
      }
    } catch (e) {
      Get.snackbar('Oh Snap!', e.toString());
    } finally {
      isLoading.value = false; // Set loading to false at the end
      // Fetch output devices related to the containers
      Get.find<OutputDevicesController>().fetchOutputDevices();
    }
  }

  // Future<void> fetchContainers() async {
  //   try{
  //     isLoading.value=true;
  //     final usersInfor= await userRepository.fetchUserDetails();
  //     final containers= await containerRepository.fetchContainers(usersInfor.containers);
  //     containerList.assignAll(containers);
  //     containerId=containerList[0].containerId.obs;
  //     plantIdsList.assignAll(containerList[0].plantIds);
  //   }catch(e){
  //     Get.snackbar('Oh Snap!', e.toString());
  //   }finally{
  //     isLoading.value=false;
  //     final controllerOutputDevices = Get.put(OutputDevicesController());
  //
  //   }
  // }

  Future<void> updateRemainingArea(String containerId, double newRemainingArea) async {
    try {
      await containerRepository.updateRemainingArea(containerId, newRemainingArea);
      // Optionally, update the local containerList with the new remaining area
      final container = containerList.firstWhere((c) => c.containerId == containerId);
      container.remainingArea = newRemainingArea;
      container.updatedAt = DateTime.now();
      containerList.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update remaining area: $e');
    }
  }



}