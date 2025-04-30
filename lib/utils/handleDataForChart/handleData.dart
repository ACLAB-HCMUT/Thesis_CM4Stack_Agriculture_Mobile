// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:thesis_smart_farm/features/dashboard/models/sensor/historical/sensorData/humid/humid.dart';
// //
// // import '../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
// //
// // class ProcessDataForChartUtils{
// //   static  List<FlSpot> processData(List<AbstractSensorData> data, String sensorType) {
// //     List<FlSpot> chartData = [];
// //
// //     for (var entry in data) {
// //       // Check if the timestamp exists
// //       if (entry.timestamp != null) {
// //         // Convert timestamp to hour-based X-axis value
// //         double xValue = entry.timestamp.hour.toDouble() +
// //             (entry.timestamp.minute / 60.0);
// //         entry=entry as HumiditySensorData;
// //         // Use the `humidity` value for the Y-axis
// //         chartData.add(FlSpot(xValue, entry.humidity));
// //       }
// //     }
// //
// //     return chartData;
// //   }
// // }
//
// import 'package:fl_chart/fl_chart.dart';
//
// import '../../features/dashboard/models/sensor/historical/sensorData/humid/humid.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
//
// class ProcessDataForChartUtils {
//   static List<FlSpot> processDataforDay(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Define starting and ending points of the day
//     DateTime startOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       0, // Start at 00:00
//       0,
//     );
//
//     DateTime endOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       23,
//       59,
//     );
//
//     // Define the interval in minutes (e.g., 1 hour)
//     const int intervalMinutes = 59;
//
//     // Current pointer in time
//     DateTime currentPoint = startOfDay;
//
//     int xIndex = 0; // Start X-axis at 0 (00:00)
//
//     // Iterate through the day in defined intervals
//     while (currentPoint.isBefore(endOfDay)) {
//       // Find the closest data point after or at the current point
//       AbstractSensorData? closestData = data.firstWhere(
//             (entry) =>
//         entry.timestamp.isAfter(currentPoint) ||
//             entry.timestamp.isAtSameMomentAs(currentPoint),
//         orElse: () => AbstractSensorData.empty("humid"),
//       );
//
//       if (closestData.timestamp.isAtSameMomentAs(DateTime.now()) == false) {
//         // Add FlSpot with X-axis based on interval and Y-axis based on sensor data
//         if (sensorType == 'humid' && closestData is HumiditySensorData) {
//           chartData.add(FlSpot(xIndex.toDouble(), closestData.humidity));
//         }
//         // Additional cases for other sensor types can go here
//       }
//
//       // Move the pointer to the next interval
//       currentPoint = currentPoint.add(Duration(minutes: intervalMinutes));
//       xIndex++; // Increment X-axis index for the next interval
//     }
//
//     return chartData;
//   }
//
//
//   static List<FlSpot> processDataforWeek(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Define starting and ending points of the day
//     DateTime startOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       0, // Start at 00:00
//       0,
//     );
//
//     DateTime endOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       23,
//       59,
//     );
//
//     // Define the interval in minutes (e.g., 1 hour)
//     const int intervalMinutes = 59;
//
//     // Current pointer in time
//     DateTime currentPoint = startOfDay;
//
//     int xIndex = 0; // Start X-axis at 0 (00:00)
//
//     // Iterate through the day in defined intervals
//     while (currentPoint.isBefore(endOfDay)) {
//       // Find the closest data point after or at the current point
//       AbstractSensorData? closestData = data.firstWhere(
//             (entry) =>
//         entry.timestamp.isAfter(currentPoint) ||
//             entry.timestamp.isAtSameMomentAs(currentPoint),
//         orElse: () => AbstractSensorData.empty("humid"),
//       );
//
//       if (closestData.timestamp.isAtSameMomentAs(DateTime.now()) == false) {
//         // Add FlSpot with X-axis based on interval and Y-axis based on sensor data
//         if (sensorType == 'humid' && closestData is HumiditySensorData) {
//           chartData.add(FlSpot(xIndex.toDouble(), closestData.humidity));
//         }
//         // Additional cases for other sensor types can go here
//       }
//
//       // Move the pointer to the next interval
//       currentPoint = currentPoint.add(Duration(minutes: intervalMinutes));
//       xIndex++; // Increment X-axis index for the next interval
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> processDataforMonth(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Define starting and ending points of the day
//     DateTime startOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       0, // Start at 00:00
//       0,
//     );
//
//     DateTime endOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       23,
//       59,
//     );
//
//     // Define the interval in minutes (e.g., 1 hour)
//     const int intervalMinutes = 59;
//
//     // Current pointer in time
//     DateTime currentPoint = startOfDay;
//
//     int xIndex = 0; // Start X-axis at 0 (00:00)
//
//     // Iterate through the day in defined intervals
//     while (currentPoint.isBefore(endOfDay)) {
//       // Find the closest data point after or at the current point
//       AbstractSensorData? closestData = data.firstWhere(
//             (entry) =>
//         entry.timestamp.isAfter(currentPoint) ||
//             entry.timestamp.isAtSameMomentAs(currentPoint),
//         orElse: () => AbstractSensorData.empty("humid"),
//       );
//
//       if (closestData.timestamp.isAtSameMomentAs(DateTime.now()) == false) {
//         // Add FlSpot with X-axis based on interval and Y-axis based on sensor data
//         if (sensorType == 'humid' && closestData is HumiditySensorData) {
//           chartData.add(FlSpot(xIndex.toDouble(), closestData.humidity));
//         }
//         // Additional cases for other sensor types can go here
//       }
//
//       // Move the pointer to the next interval
//       currentPoint = currentPoint.add(Duration(minutes: intervalMinutes));
//       xIndex++; // Increment X-axis index for the next interval
//     }
//
//     return chartData;
//   }
//
//
//
//   static List<FlSpot> processDataforYear(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Define starting and ending points of the day
//     DateTime startOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       0, // Start at 00:00
//       0,
//     );
//
//     DateTime endOfDay = DateTime(
//       data.first.timestamp.year,
//       data.first.timestamp.month,
//       data.first.timestamp.day,
//       23,
//       59,
//     );
//
//     // Define the interval in minutes (e.g., 1 hour)
//     const int intervalMinutes = 59;
//
//     // Current pointer in time
//     DateTime currentPoint = startOfDay;
//
//     int xIndex = 0; // Start X-axis at 0 (00:00)
//
//     // Iterate through the day in defined intervals
//     while (currentPoint.isBefore(endOfDay)) {
//       // Find the closest data point after or at the current point
//       AbstractSensorData? closestData = data.firstWhere(
//             (entry) =>
//         entry.timestamp.isAfter(currentPoint) ||
//             entry.timestamp.isAtSameMomentAs(currentPoint),
//         orElse: () => AbstractSensorData.empty("humid"),
//       );
//
//       if (closestData.timestamp.isAtSameMomentAs(DateTime.now()) == false) {
//         // Add FlSpot with X-axis based on interval and Y-axis based on sensor data
//         if (sensorType == 'humid' && closestData is HumiditySensorData) {
//           chartData.add(FlSpot(xIndex.toDouble(), closestData.humidity));
//         }
//         // Additional cases for other sensor types can go here
//       }
//
//       // Move the pointer to the next interval
//       currentPoint = currentPoint.add(Duration(minutes: intervalMinutes));
//       xIndex++; // Increment X-axis index for the next interval
//     }
//
//     return chartData;
//   }
//
//   static String selectCurrentFilter(int indexOfFilter){
//     switch(indexOfFilter){
//       case 0:
//         return 'day';
//       case 1:
//         return 'week';
//       case 2:
//         return 'month';
//       case 3:
//         return 'year';
//       default:
//         return 'day';
//     }
//   }
// }







// import 'package:fl_chart/fl_chart.dart';
//
// import '../../features/dashboard/models/sensor/historical/sensorData/humid/humid.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
//
// class ProcessDataForChartUtils {
//   // Process data for the day
//   static List<FlSpot> processDataForDay(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     DateTime startOfDay = DateTime(data.first.timestamp.year, data.first.timestamp.month, data.first.timestamp.day);
//     DateTime endOfDay = startOfDay.add(Duration(hours: 24));
//     DateTime currentHour = startOfDay;
//     for (int hour = 0; hour < 24; hour++) {
//
//       List<AbstractSensorData> hourlyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentHour) &&
//             entry.timestamp.isBefore(currentHour.add(Duration(hours: 1)));
//       }).toList();
//
//       double median = _calculateMedian(hourlyData, sensorType);
//       chartData.add(FlSpot(hour.toDouble(), median));
//       currentHour = startOfDay.add(Duration(hours: hour));
//     }
//
//     return chartData;
//   }
//
//   // Process data for the week
//   static List<FlSpot> processDataForWeek(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     DateTime startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
//     for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
//       DateTime currentDay = startOfWeek.add(Duration(days: dayOffset));
//       List<AbstractSensorData> dailyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentDay) &&
//             entry.timestamp.isBefore(currentDay.add(Duration(days: 1)));
//       }).toList();
//
//       double median = _calculateMedian(dailyData, sensorType);
//       chartData.add(FlSpot(dayOffset.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   // Process data for the month
//   // static List<FlSpot> processDataForMonth(List<AbstractSensorData> data, String sensorType) {
//   //   List<FlSpot> chartData = [];
//   //   data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//   //
//   //   List<int> selectedDays = [1, 5, 10, 15, 20, 25, 30];
//   //   for (int day in selectedDays) {
//   //     List<AbstractSensorData> dayData = data.where((entry) {
//   //       return entry.timestamp.day == day;
//   //     }).toList();
//   //
//   //     double median = _calculateMedian(dayData, sensorType);
//   //     chartData.add(FlSpot(day.toDouble(), median));
//   //   }
//   //
//   //   return chartData;
//   // }
//   static List<FlSpot> processDataForMonth(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Get the number of days in the current month
//     DateTime now = DateTime.now();
//     int daysInMonth = DateTime(now.year, now.month + 1, 0).day; // Last day of current month
//
//     // Define interval size (e.g., group every 5 days)
//     int intervalSize = 5;
//
//     double idx=0.0;
//
//     // Loop through intervals
//     for (int startDay = 0; startDay <= daysInMonth; startDay += intervalSize) {
//       int endDay = (startDay + intervalSize - 1).clamp(startDay, daysInMonth); // Ensure we don't exceed month days
//
//       // Filter data for the current interval
//       List<AbstractSensorData> intervalData = data.where((entry) {
//         return entry.timestamp.day >= startDay && entry.timestamp.day <= endDay;
//       }).toList();
//
//       // Calculate median for the interval
//       double median = _calculateMedian(intervalData, sensorType);
//
//       // Use the midpoint of the interval for the X-axis
//
//
//       // Add data point to the chart
//       chartData.add(FlSpot(idx, median));
//       idx+=1.0;
//
//     }
//
//     return chartData;
//   }
//
//
//   // Process data for the year (by quarter)
//   static List<FlSpot> processDataForYear(List<AbstractSensorData> data, String sensorType) {
//     List<FlSpot> chartData = [];
//
//     // Sort the data by timestamp
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     // Initialize quarters map with indices 0 to 3
//     Map<int, List<AbstractSensorData>> quarters = {
//       0: [], // Q1
//       1: [], // Q2
//       2: [], // Q3
//       3: []  // Q4
//     };
//
//     // Group data into quarters (0 for Q1, 1 for Q2, 2 for Q3, 3 for Q4)
//     for (var entry in data) {
//       int quarter = (entry.timestamp.month - 1) ~/ 3; // Adjust to start from 0
//       quarters[quarter]?.add(entry);
//     }
//
//     // Calculate the median for each quarter
//     for (int quarter = 0; quarter <= 3; quarter++) {
//       double median = _calculateMedian(quarters[quarter] ?? [], sensorType);
//       chartData.add(FlSpot(quarter.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//
//   // Helper function to calculate the median
//   static double _calculateMedian(List<AbstractSensorData> data, String sensorType) {
//     if (data.isEmpty) return 0.0;
//     List<double> values = data
//         .where((entry) => entry is HumiditySensorData)
//         .map((entry) => (entry as HumiditySensorData).humidity)
//         .toList()
//       ..sort();
//
//     int mid = values.length ~/ 2;
//     return values.length.isOdd ? values[mid] : (values[mid - 1] + values[mid]) / 2;
//   }
//
//   static String selectCurrentFilter(int indexOfFilter){
//     switch(indexOfFilter){
//       case 0:
//         return 'day';
//       case 1:
//         return 'week';
//       case 2:
//         return 'month';
//       case 3:
//         return 'year';
//       default:
//         return 'day';
//     }
//   }
//
// }


// import 'package:fl_chart/fl_chart.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/humid/humid.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/temperature/temperature.dart';
// import '../../features/dashboard/models/sensor/historical/sensorData/soil/soil.dart';
//
// class ProcessDataForChartUtils {
//   // Process data for humid, temperature, and soil
//   static Map<int, List<FlSpot>> processData(
//       List<AbstractSensorData> data, String sensorType, int filterType) {
//     Map<int, List<FlSpot>> chartData = {0: [], 1: [], 2: []};
//
//     // Filter and process based on sensorType
//     if (sensorType == "humid") {
//       chartData[0] = _processHumidOrTempData(data, "humidity", filterType);
//     } else if (sensorType == "temperature") {
//       chartData[0] = _processHumidOrTempData(data, "temperature", filterType);
//     } else if (sensorType == "soil") {
//       chartData[0] = _processSoilData(data, "nitrogen", filterType);
//       chartData[1] = _processSoilData(data, "phosphorus", filterType);
//       chartData[2] = _processSoilData(data, "potassium", filterType);
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processHumidOrTempData(
//       List<AbstractSensorData> data, String key, int filterType) {
//     List<FlSpot> chartData = [];
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     switch (filterType) {
//       case 0: // Day
//         chartData = _processDataForDay(data, key);
//         break;
//       case 1: // Week
//         chartData = _processDataForWeek(data, key);
//         break;
//       case 2: // Month
//         chartData = _processDataForMonth(data, key);
//         break;
//       case 3: // Year
//         chartData = _processDataForYear(data, key);
//         break;
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processSoilData(
//       List<AbstractSensorData> data, String key, int filterType) {
//     List<FlSpot> chartData = [];
//     data.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//     switch (filterType) {
//       case 0: // Day
//         chartData = _processDataForDay(data, key);
//         break;
//       case 1: // Week
//         chartData = _processDataForWeek(data, key);
//         break;
//       case 2: // Month
//         chartData = _processDataForMonth(data, key);
//         break;
//       case 3: // Year
//         chartData = _processDataForYear(data, key);
//         break;
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processDataForDay(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     DateTime startOfDay = DateTime(data.first.timestamp.year,
//         data.first.timestamp.month, data.first.timestamp.day);
//
//     for (int hour = 0; hour < 24; hour++) {
//       DateTime currentHour = startOfDay.add(Duration(hours: hour));
//       List<AbstractSensorData> hourlyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentHour) &&
//             entry.timestamp.isBefore(currentHour.add(Duration(hours: 1)));
//       }).toList();
//
//       double median = _calculateMedian(hourlyData, key);
//       chartData.add(FlSpot(hour.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processDataForWeek(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     DateTime startOfWeek =
//     DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
//
//     for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
//       DateTime currentDay = startOfWeek.add(Duration(days: dayOffset));
//       List<AbstractSensorData> dailyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentDay) &&
//             entry.timestamp.isBefore(currentDay.add(Duration(days: 1)));
//       }).toList();
//
//       double median = _calculateMedian(dailyData, key);
//       chartData.add(FlSpot(dayOffset.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processDataForMonth(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     int daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
//         .day; // Get number of days in current month
//
//     for (int startDay = 1; startDay <= daysInMonth; startDay += 5) {
//       int endDay = (startDay + 4).clamp(1, daysInMonth);
//
//       List<AbstractSensorData> intervalData = data.where((entry) {
//         return entry.timestamp.day >= startDay &&
//             entry.timestamp.day <= endDay;
//       }).toList();
//
//       double median = _calculateMedian(intervalData, key);
//       chartData.add(FlSpot(startDay.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   static List<FlSpot> _processDataForYear(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     Map<int, List<AbstractSensorData>> quarters = {0: [], 1: [], 2: [], 3: []};
//
//     for (var entry in data) {
//       int quarter = (entry.timestamp.month - 1) ~/ 3;
//       quarters[quarter]?.add(entry);
//     }
//
//     for (int quarter = 0; quarter <= 3; quarter++) {
//       double median = _calculateMedian(quarters[quarter] ?? [], key);
//       chartData.add(FlSpot(quarter.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   static double _calculateMedian(
//       List<AbstractSensorData> data, String key) {
//     if (data.isEmpty) return 0.0;
//
//     List<double> values;
//     if (key == "humidity") {
//       values = data
//           .where((entry) => entry is HumiditySensorData)
//           .map((entry) => (entry as HumiditySensorData).humidity)
//           .toList();
//     } else if (key == "temperature") {
//       values = data
//           .where((entry) => entry is TemperatureSensorData)
//           .map((entry) => (entry as TemperatureSensorData).temperature)
//           .toList();
//     } else {
//       values = data
//           .where((entry) => entry is SoilSensorData)
//           .map((entry) {
//         if (key == "nitrogen") {
//           return (entry as SoilSensorData).nitrogen;
//         } else if (key == "phosphorus") {
//           return (entry as SoilSensorData).phosphorus;
//         } else {
//           return (entry as SoilSensorData).kali;
//         }
//       }).toList();
//     }
//
//     values.sort();
//     int mid = values.length ~/ 2;
//     return values.length.isOdd
//         ? values[mid]
//         : (values[mid - 1] + values[mid]) / 2;
//   }
//
//   static String selectCurrentFilter(int indexOfFilter){
//     switch(indexOfFilter){
//       case 0:
//         return 'day';
//       case 1:
//         return 'week';
//       case 2:
//         return 'month';
//       case 3:
//         return 'year';
//       default:
//         return 'day';
//     }
//   }
// }
//


import 'package:fl_chart/fl_chart.dart';
import '../../features/dashboard/models/sensor/historical/sensorData/humid/humid.dart';
import '../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
import '../../features/dashboard/models/sensor/historical/sensorData/temperature/temperature.dart';
import '../../features/dashboard/models/sensor/historical/sensorData/soil/soil.dart';

// class ProcessDataForChartUtils {
//   /// Main function to process sensor data
//   static Map<int, List<FlSpot>> processData(
//       List<AbstractSensorData> data, String sensorType, int filterType) {
//     Map<int, List<FlSpot>> chartData = {0: [], 1: [], 2: []};
//
//     if (sensorType == "humid") {
//       chartData[0] = _processHumidOrTempData(data, "humidity", filterType);
//     } else if (sensorType == "temperature") {
//       chartData[0] = _processHumidOrTempData(data, "temperature", filterType);
//     } else if (sensorType == "soil") {
//       chartData[0] = _processSoilData(data, "nitrogen", filterType);
//       chartData[1] = _processSoilData(data, "phosphorus", filterType);
//       chartData[2] = _processSoilData(data, "kali", filterType);
//     }
//
//     return chartData;
//   }
//
//   /// Process data for humidity or temperature
//   static List<FlSpot> _processHumidOrTempData(
//       List<AbstractSensorData> data, String key, int filterType) {
//     switch (filterType) {
//       case 0:
//         return _processDataForDay(data, key);
//       case 1:
//         return _processDataForWeek(data, key);
//       case 2:
//         return _processDataForMonth(data, key);
//       case 3:
//         return _processDataForYear(data, key);
//       default:
//         return [];
//     }
//   }
//
//   /// Process data for soil nutrients
//   static List<FlSpot> _processSoilData(
//       List<AbstractSensorData> data, String key, int filterType) {
//     switch (filterType) {
//       case 0:
//         return _processDataForDay(data, key);
//       case 1:
//         return _processDataForWeek(data, key);
//       case 2:
//         return _processDataForMonth(data, key);
//       case 3:
//         return _processDataForYear(data, key);
//       default:
//         return [];
//     }
//   }
//
//   /// Process data for a day (hourly intervals)
//   static List<FlSpot> _processDataForDay(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     DateTime startOfDay = DateTime(data.first.timestamp.year,
//         data.first.timestamp.month, data.first.timestamp.day);
//
//     for (int hour = 0; hour < 24; hour++) {
//       DateTime currentHour = startOfDay.add(Duration(hours: hour));
//       List<AbstractSensorData> hourlyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentHour) &&
//             entry.timestamp.isBefore(currentHour.add(Duration(hours: 1)));
//       }).toList();
//
//       double median = _calculateMedian(hourlyData, key);
//       chartData.add(FlSpot(hour.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   /// Process data for a week (daily intervals)
//   static List<FlSpot> _processDataForWeek(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     DateTime startOfWeek =
//     DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
//
//     for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
//       DateTime currentDay = startOfWeek.add(Duration(days: dayOffset));
//       List<AbstractSensorData> dailyData = data.where((entry) {
//         return entry.timestamp.isAfter(currentDay) &&
//             entry.timestamp.isBefore(currentDay.add(Duration(days: 1)));
//       }).toList();
//
//       double median = _calculateMedian(dailyData, key);
//       chartData.add(FlSpot(dayOffset.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   /// Process data for a month (5-day intervals)
//   static List<FlSpot> _processDataForMonth(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//
//     int intervalSize = 5;
//     int daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
//         .day;
//
//     for (int startDay = 0; startDay <= daysInMonth; startDay += intervalSize) {
//       int endDay = (startDay + 4).clamp(1, daysInMonth);
//
//       List<AbstractSensorData> intervalData = data.where((entry) {
//         return entry.timestamp.day >= startDay &&
//             entry.timestamp.day <= endDay;
//       }).toList();
//
//       double median = _calculateMedian(intervalData, key);
//       chartData.add(FlSpot((startDay / 5).floorToDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   /// Process data for a year (quarterly intervals)
//   static List<FlSpot> _processDataForYear(
//       List<AbstractSensorData> data, String key) {
//     List<FlSpot> chartData = [];
//     Map<int, List<AbstractSensorData>> quarters = {0: [], 1: [], 2: [], 3: []};
//
//     for (var entry in data) {
//       int quarter = (entry.timestamp.month - 1) ~/ 3;
//       quarters[quarter]?.add(entry);
//     }
//
//     for (int quarter = 0; quarter <= 3; quarter++) {
//       double median = _calculateMedian(quarters[quarter] ?? [], key);
//       chartData.add(FlSpot(quarter.toDouble(), median));
//     }
//
//     return chartData;
//   }
//
//   /// Helper function to calculate median
//   static double _calculateMedian(List<AbstractSensorData> data, String key) {
//     if (data.isEmpty) return 0.0;
//
//     List<double> values;
//     if (key == "humidity") {
//       values = data
//           .where((entry) => entry is HumiditySensorData)
//           .map((entry) => (entry as HumiditySensorData).humidity)
//           .toList();
//     } else if (key == "temperature") {
//       values = data
//           .where((entry) => entry is TemperatureSensorData)
//           .map((entry) => (entry as TemperatureSensorData).temperature)
//           .toList();
//     } else {
//       values = data
//           .where((entry) => entry is SoilSensorData)
//           .map((entry) {
//         if (key == "nitrogen") {
//           return (entry as SoilSensorData).nitrogen;
//         } else if (key == "phosphorus") {
//           return (entry as SoilSensorData).phosphorus;
//         } else {
//           return (entry as SoilSensorData).kali;
//         }
//       }).toList();
//     }
//
//     values.sort();
//     int mid = values.length ~/ 2;
//     return values.length.isOdd
//         ? values[mid]
//         : (values[mid - 1] + values[mid]) / 2;
//   }
//
//   static String selectCurrentFilter(int indexOfFilter){
//     switch(indexOfFilter){
//       case 0:
//         return 'day';
//       case 1:
//         return 'week';
//       case 2:
//         return 'month';
//       case 3:
//         return 'year';
//       default:
//         return 'day';
//     }
//   }
// }
class ProcessDataForChartUtils {
  static Map<int, List<FlSpot>> processData(List<AbstractSensorData> data, String sensorType, int filterType) {
    if (data.isEmpty) {
      print('No data provided to process');
      return {0: [], 1: [], 2: []};
    }
    Map<int, List<FlSpot>> chartData = {0: [], 1: [], 2: []};
    if (sensorType == "humid") {
      chartData[0] = _processHumidOrTempData(data, "humidity", filterType);
      print('The data of chart in humid sensor type is: ${chartData[0]}');
    } else if (sensorType == "temperature") {
      chartData[0] = _processHumidOrTempData(data, "temperature", filterType);
      print('The data of chart in temperature sensor type is: ${chartData[0]}');
    } else if (sensorType == "soil") {
      print('The data of chart in soil sensor type is: ${chartData[0]}');
      chartData[0] = _processSoilData(data, "nitrogen", filterType);
      chartData[1] = _processSoilData(data, "phosphorus", filterType);
      chartData[2] = _processSoilData(data, "kali", filterType);
    }
    print('Processed chartData: $chartData');
    return chartData;
  }

  static List<FlSpot> _processDataForDay(List<AbstractSensorData> data, String key) {
    List<FlSpot> chartData = [];
    DateTime startOfDay = DateTime(data.first.timestamp.year, data.first.timestamp.month, data.first.timestamp.day);
    for (int hour = 0; hour < 24; hour++) {
      DateTime currentHour = startOfDay.add(Duration(hours: hour));
      List<AbstractSensorData> hourlyData = data.where((entry) => entry.timestamp.isAfter(currentHour) && entry.timestamp.isBefore(currentHour.add(Duration(hours: 1)))).toList();
      double median = _calculateMedian(hourlyData, key);
      chartData.add(FlSpot(hour.toDouble(), median));
    }
    print('Processed data for day: $chartData');
    if (chartData.isEmpty) print('Warning: No data for day');
    return chartData;
  }

  static List<FlSpot> _processHumidOrTempData(
      List<AbstractSensorData> data, String key, int filterType) {
    switch (filterType) {
      case 0:
        return _processDataForDay(data, key);
      case 1:
        return _processDataForWeek(data, key);
      case 2:
        return _processDataForMonth(data, key);
      case 3:
        return _processDataForYear(data, key);
      default:
        return [];
    }
  }

  /// Process data for soil nutrients
  static List<FlSpot> _processSoilData(
      List<AbstractSensorData> data, String key, int filterType) {
    switch (filterType) {
      case 0:
        return _processDataForDay(data, key);
      case 1:
        return _processDataForWeek(data, key);
      case 2:
        return _processDataForMonth(data, key);
      case 3:
        return _processDataForYear(data, key);
      default:
        return [];
    }
  }

  /// Process data for a day (hourly intervals)
  // static List<FlSpot> _processDataForDay(
  //     List<AbstractSensorData> data, String key) {
  //   List<FlSpot> chartData = [];
  //   DateTime startOfDay = DateTime(data.first.timestamp.year,
  //       data.first.timestamp.month, data.first.timestamp.day);
  //
  //   for (int hour = 0; hour < 24; hour++) {
  //     DateTime currentHour = startOfDay.add(Duration(hours: hour));
  //     List<AbstractSensorData> hourlyData = data.where((entry) {
  //       return entry.timestamp.isAfter(currentHour) &&
  //           entry.timestamp.isBefore(currentHour.add(Duration(hours: 1)));
  //     }).toList();
  //
  //     double median = _calculateMedian(hourlyData, key);
  //     chartData.add(FlSpot(hour.toDouble(), median));
  //   }
  //
  //   return chartData;
  // }

  /// Process data for a week (daily intervals)
  static List<FlSpot> _processDataForWeek(
      List<AbstractSensorData> data, String key) {
    List<FlSpot> chartData = [];
    DateTime startOfWeek =
    DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

    for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
      DateTime currentDay = startOfWeek.add(Duration(days: dayOffset));
      List<AbstractSensorData> dailyData = data.where((entry) {
        return entry.timestamp.isAfter(currentDay) &&
            entry.timestamp.isBefore(currentDay.add(Duration(days: 1)));
      }).toList();

      double median = _calculateMedian(dailyData, key);
      chartData.add(FlSpot(dayOffset.toDouble(), median));
    }

    return chartData;
  }

  /// Process data for a month (5-day intervals)
  static List<FlSpot> _processDataForMonth(
      List<AbstractSensorData> data, String key) {
    List<FlSpot> chartData = [];

    int intervalSize = 5;
    int daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
        .day;

    for (int startDay = 0; startDay <= daysInMonth; startDay += intervalSize) {
      int endDay = (startDay + 4).clamp(1, daysInMonth);

      List<AbstractSensorData> intervalData = data.where((entry) {
        return entry.timestamp.day >= startDay &&
            entry.timestamp.day <= endDay;
      }).toList();

      double median = _calculateMedian(intervalData, key);
      chartData.add(FlSpot((startDay / 5).floorToDouble(), median));
    }

    return chartData;
  }

  /// Process data for a year (quarterly intervals)
  static List<FlSpot> _processDataForYear(
      List<AbstractSensorData> data, String key) {
    List<FlSpot> chartData = [];
    Map<int, List<AbstractSensorData>> quarters = {0: [], 1: [], 2: [], 3: []};

    for (var entry in data) {
      int quarter = (entry.timestamp.month - 1) ~/ 3;
      quarters[quarter]?.add(entry);
    }

    for (int quarter = 0; quarter <= 3; quarter++) {
      double median = _calculateMedian(quarters[quarter] ?? [], key);
      chartData.add(FlSpot(quarter.toDouble(), median));
    }

    return chartData;
  }

  /// Helper function to calculate median
  static double _calculateMedian(List<AbstractSensorData> data, String key) {
    if (data.isEmpty) return 0.0;

    List<double> values;
    if (key == "humidity") {
      values = data
          .where((entry) => entry is HumiditySensorData)
          .map((entry) => (entry as HumiditySensorData).humidity)
          .toList();
    } else if (key == "temperature") {
      values = data
          .where((entry) => entry is TemperatureSensorData)
          .map((entry) => (entry as TemperatureSensorData).temperature)
          .toList();
    } else {
      values = data
          .where((entry) => entry is SoilSensorData)
          .map((entry) {
        if (key == "nitrogen") {
          return (entry as SoilSensorData).nitrogen;
        } else if (key == "phosphorus") {
          return (entry as SoilSensorData).phosphorus;
        } else {
          return (entry as SoilSensorData).kali;
        }
      }).toList();
    }

    values.sort();
    int mid = values.length ~/ 2;
    return values.length.isOdd
        ? values[mid]
        : (values[mid - 1] + values[mid]) / 2;
  }

  static String selectCurrentFilter(int indexOfFilter){
    switch(indexOfFilter){
      case 0:
        return 'day';
      case 1:
        return 'week';
      case 2:
        return 'month';
      case 3:
        return 'year';
      default:
        return 'day';
    }
  }
}
