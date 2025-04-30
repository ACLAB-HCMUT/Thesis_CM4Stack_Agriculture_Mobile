// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../../data/repository/scheduler/scheduler_repository.dart';
//
// class SchedulerController extends GetxController {
//   final SchedulerRepository schedulerRepository = Get.put(SchedulerRepository());
//   // Enum-like values for options
//   static const int SCHEDULER_BAT_TAT = 1;
//   static const int SCHEDULER_TAT_BAT = 2;
//   static const int SCHEDULER_BAT_TAT_SEPARATE = 3;
//   static const int SCHEDULER_AUTOMATIC = 4;
//   static const int SCHEDULER_IS_SET = 5;
//
//   // Observable variable to track the selected option
//   var selectedOption = 0.obs; // Default is no selection (null)
//   var curSelectedOption = 0.obs;
//   var startDate = "Select Day".obs;
//   var endDate = "Select Day".obs;
//   var startTime = "Select Time".obs;
//   var endTime = "Select Time".obs;
//   var timeTrigger = "Select Time".obs;
//   var scheduleStatus = "scheduled".obs;
//   var schedulerMode = ''.obs;  // Default value is "Select Mode"
//   var pumpMode = ''.obs;  // Initially set to Off
//   var currentMode = ''.obs;
//   var isSchedulerConfirmed = false.obs;
//   // Reactive variables for sensor readings
//   var sensorTemp = 25.0.obs;     // Example temperature sensor value (°C)
//   var sensorHumidity = 60.0.obs; // Example humidity sensor value (%)
//
//   // Reactive variables for thresholds
//   var tempThreshold = 30.0.obs;     // Temperature threshold (°C)
//   var humidityThreshold = 70.0.obs; // Humidity threshold (%)
//   var tempComparison = ">".obs;  // Default comparison for temperature
//   var humidityComparison = ">".obs;  // Default comparison for humidity
//   String combineDateAndTime(String date, String time) {
//     // Split date and time into components
//     List<String> dateParts = date.split('/');
//     List<String> timeParts = time.split(':');
//
//     int day = int.parse(dateParts[0]);
//     int month = int.parse(dateParts[1]);
//     int year = int.parse(dateParts[2]);
//     int hour = int.parse(timeParts[0]);
//     int minute = int.parse(timeParts[1]);
//
//     // Create a DateTime object
//     DateTime combinedDateTime = DateTime(year, month, day, hour, minute);
//
//     // Format the DateTime object
//     String formattedDateTime = DateFormat('MMMM d, y \'at\' HH:mm:ss').format(combinedDateTime);
//
//     // Append the explicit UTC+7 time zone
//     return "$formattedDateTime UTC+7";
//   }
//   // Update scheduler with "scheduler_on_off" mode
//   Future<void> updateSchedulerOnOff(
//       String containerId,
//       String schedulerId,
//       String deviceId,
//       ) async {
//     try {
//       if (startTime.value == "Select Time" || endTime.value == "Select Time") {
//         throw Exception("Please select valid start and end times.");
//       }
//       String formattedStartDateTime = combineDateAndTime(startDate.value, startTime.value);
//
//       // Combine end date and time
//       String formattedEndDateTime = combineDateAndTime(endDate.value, endTime.value);
//       // Prepare the payload for the scheduler
//       Map<String, dynamic> updatedData = {
//         "startTime": formattedStartDateTime,
//         "endTime": formattedEndDateTime,
//         "mode": "scheduler_on_off",
//         "outputDeviceId": deviceId,
//       };
//
//       // Call repository to update the scheduler
//       await schedulerRepository.updateScheduler(containerId, schedulerId, updatedData);
//
//       Get.snackbar("Success", "Scheduler ON-OFF updated successfully.");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
//   Future<void> updateSchedulerOffOn(
//       String containerId,
//       String schedulerId,
//       String deviceId,
//       ) async {
//     try {
//       if (startTime.value == "Select Time" || endTime.value == "Select Time") {
//         throw Exception("Please select valid start and end times.");
//       }
//       String formattedStartDateTime = combineDateAndTime(startDate.value, startTime.value);
//
//       // Combine end date and time
//       String formattedEndDateTime = combineDateAndTime(endDate.value, endTime.value);
//       // Prepare the payload for the scheduler
//       Map<String, dynamic> updatedData = {
//         "startTime": formattedStartDateTime,
//         "endTime": formattedEndDateTime,
//         "mode": "scheduler_off_on",
//         "outputDeviceId": deviceId,
//       };
//
//       // Call repository to update the scheduler
//       await schedulerRepository.updateScheduler(containerId, schedulerId, updatedData);
//
//       Get.snackbar("Success", "Scheduler ON-OFF updated successfully.");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
//
//   Future<void> updateSchedulerWithTimeTrigger({
//     required String containerId,
//     required String schedulerId,
//     required String deviceId,
//     required String timeTrigger,
//   }) async {
//     try {
//
//       final Map<String, dynamic> updatedData = {
//         "timeTrigger": timeTrigger,
//         "mode": schedulerMode.value == 'Set time ON for Pump' ? "scheduler_on" : "scheduler_off",
//         "outputDeviceId": deviceId,
//       };
//
//       // Call the repository method
//       await schedulerRepository.updateScheduler(containerId, schedulerId, updatedData);
//
//       Get.snackbar("Success", "Scheduler updated successfully!");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
//   // Method to set the scheduler mode (On/Off)
//   void setSchedulerModeSensor(String mode) {
//     if (mode == 'ON' || mode == 'OFF') {
//       // Valid mode selection
//       pumpMode.value = mode;
//     }
//   }
//
//   // Method to confirm the schedule
//   bool confirmScheduler() {
//     // Mark the scheduler as confirmed
//     return isSchedulerConfirmed.value = true;
//
//   }
//   String getSchedulerModeONorOFF() {
//     return schedulerMode.value;
//   }
//   // Method to set the scheduler mode (either ON or OFF for the pump)
//   void setSchedulerMode(String mode) {
//     if (mode == 'Set time ON for Pump' || mode == 'Set time OFF for Pump') {
//       // Valid mode selection
//       schedulerMode.value = mode;
//     }
//   }
//   // Method to pick a date
//   Future<void> pickDate(BuildContext context, RxString dateField) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       dateField.value = "${picked.day}/${picked.month}/${picked.year}";
//     }
//   }
//
//   // Method to pick a time
//   Future<void> pickTime(BuildContext context, RxString timeField) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       timeField.value = "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
//     }
//   }
//   // Method to update the current mode when the scheduler is set
//   void setCurrentMode(int mode) {
//     switch (mode) {
//       case SCHEDULER_BAT_TAT:
//         currentMode.value = 'Scheduler ON - OFF';
//         break;
//       case SCHEDULER_TAT_BAT:
//         currentMode.value = 'Scheduler OFF - ON';
//         break;
//       case SCHEDULER_BAT_TAT_SEPARATE:
//         currentMode.value = 'Scheduler ON or OFF';
//         break;
//       case SCHEDULER_AUTOMATIC:
//         currentMode.value = 'Automatic Mode';
//         break;
//       default:
//         currentMode.value = '';
//     }
//   }
//
//   // Method to toggle the selected option
//   void toggleSelectedOption(int option) {
//     if(isSchedulerConfirmed.value){
//       return;
//     }
//     if (selectedOption.value == option) {
//       selectedOption.value = 0;  // Deselect the option
//     } else {
//       selectedOption.value = option;
//     }
//   }
//   // Check if an option is selected
//   bool isSelected(int option) {
//     return selectedOption.value == option;
//   }
//
//   void confirmScheduleModal(BuildContext context) {
//     // Show the confirmation modal
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Scheduler is set successfully"),
//           content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//           // Check which mode is selected and show content accordingly
//           if (selectedOption.value == SchedulerController.SCHEDULER_BAT_TAT)
//           // Scheduler ON - OFF
//           Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("PUMP 1 ON: ${startTime.value}, ${startDate.value}"),
//             Text("PUMP 1 OFF: ${endTime.value}, ${endDate.value}"),
//           ],
//         ),
//           if (selectedOption.value == SchedulerController.SCHEDULER_TAT_BAT)
//           // Scheduler OFF - ON
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("PUMP 1 OFF: ${startTime.value}, ${startDate.value}"),
//               Text("PUMP 1 ON: ${endTime.value}, ${endDate.value}"),
//             ],
//           ),
//           if (selectedOption.value == SchedulerController.SCHEDULER_BAT_TAT_SEPARATE)
//         // Scheduler ON or OFF (Only one mode)
//           Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (schedulerMode.value == 'Set time ON for Pump')
//               Text("PUMP 1 ON: ${startTime.value}, ${startDate.value}"),
//             if (schedulerMode.value == 'Set time OFF for Pump')
//               Text("PUMP 1 OFF: ${endTime.value}, ${endDate.value}"),
//           ],
//           ),
//         if (selectedOption.value == SchedulerController.SCHEDULER_AUTOMATIC)
//         // Automatic mode based on sensors
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Temperature Threshold:   ${tempComparison.value}  ${tempThreshold.value} "),
//               Text("Humidity Threshold:    ${humidityComparison.value}  ${humidityThreshold.value} "),
//               Text("Pump Mode: ${pumpMode.value}"),
//               ],
//             ),
//             ],
//           ),
//         actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();  // Close the modal
//             curSelectedOption.value = selectedOption.value;
//             selectedOption.value = 0;
//             confirmScheduler();
//           },
//           child: Text("OK"),
//         ),
//         ],
//         );
//       },
//     );
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/repository/scheduler/scheduler_repository.dart';

class SchedulerController extends GetxController {
  final SchedulerRepository schedulerRepository = Get.put(SchedulerRepository());

  // Time selection variables
  var startDate = "Select Day".obs;
  var endDate = "Select Day".obs;
  var startTime = "Select Time".obs;
  var endTime = "Select Time".obs;

  // Status tracking variables
  var isSchedulerSet = false.obs;

  @override
  void onInit() {
    super.onInit();
    // You could load any existing schedule data here
    // loadExistingSchedule();
  }

  // Format date and time for API submission
  String combineDateAndTime(String date, String time) {
    // Split date and time into components
    List<String> dateParts = date.split('/');
    List<String> timeParts = time.split(':');

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Create a DateTime object
    DateTime combinedDateTime = DateTime(year, month, day, hour, minute);

    // Format the DateTime object
    String formattedDateTime = DateFormat('MMMM d, y \'at\' HH:mm:ss').format(combinedDateTime);

    // Append the explicit UTC+7 time zone
    return "$formattedDateTime UTC+7";
  }

  // Update scheduler with ON-OFF times
  Future<void> updateSchedulerOnOff(
      String containerId,
      String schedulerId,
      String deviceId,
      ) async {
    try {
      if (startTime.value == "Select Time" || endTime.value == "Select Time" ||
          startDate.value == "Select Day" || endDate.value == "Select Day") {
        throw Exception("Please select valid times and dates.");
      }

      // Format start date and time
      String formattedStartDateTime = combineDateAndTime(startDate.value, startTime.value);

      // Format end date and time
      String formattedEndDateTime = combineDateAndTime(endDate.value, endTime.value);

      // Prepare the payload for the scheduler
      Map<String, dynamic> updatedData = {
        "startTime": formattedStartDateTime,
        "endTime": formattedEndDateTime,
        "mode": "scheduler_on_off",
        "outputDeviceId": deviceId,
      };

      // Call repository to update the scheduler
      await schedulerRepository.updateScheduler(containerId, schedulerId, updatedData);

      isSchedulerSet.value = true;
      Get.snackbar(
        "Success",
        "Pump schedule updated successfully",
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        duration: Duration(seconds: 4),
      );
    }
  }

  // Method to pick a date
  Future<void> pickDate(BuildContext context, RxString dateField) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Calendar text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateField.value = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  // Method to pick a time
  Future<void> pickTime(BuildContext context, RxString timeField) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Dial text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format minutes to always have two digits
      String minutes = picked.minute.toString().padLeft(2, '0');
      timeField.value = "${picked.hour}:$minutes";
    }
  }

  // Reset all fields - useful when modifying an existing schedule
  void resetFields() {
    startDate.value = "Select Day";
    endDate.value = "Select Day";
    startTime.value = "Select Time";
    endTime.value = "Select Time";
    isSchedulerSet.value = false;
  }

  // Load existing schedule from API (would need to be implemented)
  Future<void> loadExistingSchedule(String containerId, String schedulerId, String deviceId) async {
    try {
      // Implement loading logic from repository
      // Example:
      // final scheduleData = await schedulerRepository.getScheduler(containerId, schedulerId, deviceId);
      //
      // startTime.value = scheduleData['startTime'];
      // endTime.value = scheduleData['endTime'];
      // etc...

      // For now, we'll use placeholder data
      isSchedulerSet.value = true;
    } catch (e) {
      print("Error loading schedule: $e");
      isSchedulerSet.value = false;
    }
  }
}