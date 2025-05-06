// import 'package:get/get.dart';
// import 'package:thesis_smart_farm/features/dashboard/controllers/my_farm_controllers/container_controller/container.controller.dart';
// import 'package:thesis_smart_farm/features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
// import 'package:thesis_smart_farm/data/repository/sensor/historical_sensor_repository.dart';
//
// class DataHistoricalChartController extends GetxController {
//   final HistoricalSensorRepository _repository = Get.put(HistoricalSensorRepository());
//   final ContainerController controllerContainer = Get.find<ContainerController>();
//
//   var isLoading = false.obs;
//   var dataToday = RxList<AbstractSensorData>().obs;
//   var currentFilter= RxInt(0);
//
//   @override
//   void onInit() {
//     fetchSensorData('plant_7', 'humidSensor1', 'humid', 'day');
//     super.onInit();
//   }
//
//   Future<void> fetchSensorData(String plantId, String sensorId, String sensorType, String filter) async {
//     try {
//       isLoading.value = true;
//       List<AbstractSensorData> data = await _repository.fetchSensorReadings(
//         sensorId: sensorId,
//         sensorType: sensorType,
//         filter: filter,
//       );
//       //dataToday.value = data.obs;
//       dataToday.value.assignAll(data.obs);
//     } catch (e) {
//       print("Error fetching sensor data: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// import '../../../../../data/repository/sensor/historical_sensor_repository.dart';
import '../../../../../data/repository/sensor/real_time_sensor_repository.dart';
import '../../../../../utils/handleDataForChart/handleData.dart';
import '../../../models/sensor/historical/sensorData/sensorData.dart';

class DataHistoricalChartController extends GetxController {
  final HistoricalSensorRepository _repository = Get.put(HistoricalSensorRepository());
  var isLoading = false.obs;
  var dataToday = RxList<AbstractSensorData>().obs;
  var currentFilter = RxInt(0);

  @override
  void onInit() {
    //fetchSensorData( 'soilSensor1', 'soil', 'day');
    super.onInit();
  }

  Future<void> fetchSensorData( String sensorId, String sensorType, String filter) async {
    try {
      isLoading.value = true;
      List<AbstractSensorData> data = await _repository.fetchSensorReadings(
        sensorId: sensorId,
        sensorType: sensorType,
        filter: filter,
      );
      print("Fetched data: ${data[0]}");
      dataToday.value.assignAll(data.obs);
    } catch (e) {
      print("Error fetching sensor data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateFilter(int index,String sensorId,String type) async {
    currentFilter.value = index;
    String filter = ProcessDataForChartUtils.selectCurrentFilter(index);
    await fetchSensorData( sensorId, type, filter);
  }

}