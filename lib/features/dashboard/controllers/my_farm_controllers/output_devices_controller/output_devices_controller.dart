import 'package:get/get.dart';
import 'package:triple_h/features/dashboard/models/output_devices_model.dart';
import '../../../../../data/repository/outputDevices/output_devices_repository.dart';
import '../../../../../utils/popups/loaders.dart';
import '../container_controller/container.controller.dart';

class OutputDevicesController extends GetxController {
  static OutputDevicesController get instance => Get.find<OutputDevicesController>();

  final containerController = Get.find<ContainerController>();
  final outputDevicesRepository = Get.put(OutputDevicesRepository());

  var items = <OutputDeviceModel>[].obs; // Observable list to hold output devices
  var isLoading = false.obs; // Loading state

  @override
  void onInit() {


    fetchOutputDevices(); // Fetch output devices when the controller is initialized
    super.onInit();
  }

  // Future<void> fetchOutputDevices() async {
  //   try {
  //     isLoading.value = true; // Set loading to true
  //     // Get the list of output device IDs from the first container
  //     List<String> outputDeviceIds = containerController.containerList[0]!.outputDevices;
  //
  //     // Call the repository to fetch devices
  //     final devices = await outputDevicesRepository.getOutputDevicesByIds(outputDeviceIds);
  //
  //     // Update the items list with fetched devices
  //     items.assignAll(devices);
  //     items.refresh();
  //   } catch (e) {
  //     print("Error fetching output devices: $e");
  //     // Handle errors (e.g., show a message or log the error)
  //   } finally {
  //     items.refresh();
  //     isLoading.value = false; // Set loading to false
  //   }
  // }
  Future<void> fetchOutputDevices() async {
    try {
      isLoading.value = true; // Set loading to true at the start
      // Get the list of output device IDs from the first container
      if (containerController.containerList.isNotEmpty) {
        List<String> outputDeviceIds = containerController.containerList[0].outputDevices;

        // Fetch devices from the repository
        final devices = await outputDevicesRepository.getOutputDevicesByIds(outputDeviceIds);

        // Update the items list with fetched devices
        items.assignAll(devices);
        items.refresh(); // Force UI to update
      } else {
        print("No containers available to fetch output devices.");
      }
    } catch (e) {
      print("Error fetching output devices: $e");
      Get.snackbar("Error", "Failed to fetch output devices.");
      // Loaders.successSnackBar(
      //   title: 'Container Added',
      //   message: 'Your container list has been updated successfully.',
      // );
    } finally {
      isLoading.value = false; // Set loading to false at the end
    }
  }

  Future<void> toggleDeviceState(String deviceId, bool newState) async {
    try {

      // Optionally, update the local items list with the new state
      final device = items.firstWhere((d) => d.outputDeviceId == deviceId);
      device.status = newState ? "active" : "inactive";
      await outputDevicesRepository.updateOutputDeviceStatus(deviceId, device.status);
      await outputDevicesRepository.updateOutputDeviceStatusToRealTime(
          containerController.containerList[0].containerId, deviceId, deviceId, device.status);
      items.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update device status: $e');
    }
  }

}
