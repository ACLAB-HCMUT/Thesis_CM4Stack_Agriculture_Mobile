import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/dashboard/models/sensor/historical/sensorData/sensorData.dart';
import '../../../utils/caches/daily_caches.dart';

class HistoricalSensorRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create an instance of DailyCache for managing cached day data
  final DailyCache _dailyCache = DailyCache();

  // Fetch sensor readings for a specific filter (day, week, month, year)
  Future<List<AbstractSensorData>> fetchSensorReadings({
    required String sensorId,
    required String sensorType,
    String? filter, // Filter can be "day", "week", "month", or "year"
  }) async {
    try {
      // Get the current date
      DateTime now = DateTime.now();
      Map<String, DateTime> range = {};

      // Handle 'day' filter with cache
      if (filter == "day") {
        // Check if data is cached
        final cachedData = _dailyCache.getCachedDayData("plantedId", sensorId); // Use plantId if needed
        if (cachedData != null) {
          // Return cached data converted back to AbstractSensorData objects
          return cachedData
              .map((data) => AbstractSensorData.fromJson(sensorType,data as Map<String, dynamic> ))
              .toList();
        }

        // Calculate range for the day
        range = getDayRange(now);
      } else if (filter == "week") {
        range = getWeekRange(now);
      } else if (filter == "month") {
        range = getMonthRange(now);
      } else if (filter == "year") {
        range = getYearRange(now);
      } else {
        throw Exception("Invalid filter type: $filter");
      }

      // Get the 'readings' collection under the specific sensor with a time filter
      final querySnapshot = await _db
          .collection('sensors')
          .doc(sensorId)
          .collection('readings')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(range["start"]!))
          .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(range["end"]!))
          .orderBy('timestamp', descending: false) // Ensure ascending order
          .get();

      // Map Firestore documents to AbstractSensorData objects
      final readings = querySnapshot.docs.map((doc) {
        return AbstractSensorData.fromSnapshot(sensorType, doc);
      }).toList();

      // Cache daily data
      if (filter == "day") {
        final dataToCache = querySnapshot.docs.map((doc) => doc.data()).toList();
        _dailyCache.cacheDayData("plantId", sensorId, dataToCache); // Use plantId if needed
      }

      return readings;
    } catch (e) {
      print("Error fetching sensor readings: $e");
      return [];
    }
  }

  // Helper function to calculate the start and end of a day
  Map<String, DateTime> getDayRange(DateTime date) {
    DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return {"start": startOfDay, "end": endOfDay};
  }

  // Helper function to calculate the start and end of a week
  Map<String, DateTime> getWeekRange(DateTime date) {
    int weekday = date.weekday; // Monday is 1, Sunday is 7
    DateTime startOfWeek = date.subtract(Duration(days: weekday - 1)); // Monday
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6)); // Sunday
    return {
      "start": DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0),
      "end": DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59)
    };
  }

  // Helper function to calculate the start and end of a month
  Map<String, DateTime> getMonthRange(DateTime date) {
    DateTime startOfMonth = DateTime(date.year, date.month, 1, 0, 0, 0);
    DateTime endOfMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59);
    return {"start": startOfMonth, "end": endOfMonth};
  }

  // Helper function to calculate the start and end of a year
  Map<String, DateTime> getYearRange(DateTime date) {
    DateTime startOfYear = DateTime(date.year, 1, 1, 0, 0, 0);
    DateTime endOfYear = DateTime(date.year, 12, 31, 23, 59, 59);
    return {"start": startOfYear, "end": endOfYear};
  }

  @override
  void onClose() {
    // Dispose of the cache when the repository is destroyed
    _dailyCache.dispose();
    super.onClose();
  }
}