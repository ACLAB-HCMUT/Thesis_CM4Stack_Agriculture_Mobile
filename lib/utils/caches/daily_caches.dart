import 'dart:async';

class CacheEntry<T> {
  T data;
  DateTime timestamp;

  CacheEntry(this.data, this.timestamp);
}

class DailyCache {
  final Map<String, CacheEntry<List<dynamic>>> cache = {}; // Dynamic list for generic sensor data
  final Duration cacheExpiry = Duration(hours: 1); // Cache expiration time
  Timer? cleanupTimer;

  DailyCache() {
    // Start periodic cleanup
    cleanupTimer = Timer.periodic(Duration(minutes: 10), (timer) {
      clearExpiredCache();
    });
  }

  void cacheDayData(String plantId, String sensorId, List<dynamic> data) {
    String key = _generateKey(plantId, sensorId);
    cache[key] = CacheEntry(data, DateTime.now());
  }

  List<dynamic>? getCachedDayData(String plantId, String sensorId) {
    String key = _generateKey(plantId, sensorId);
    CacheEntry<List<dynamic>>? entry = cache[key];

    if (entry != null && !isExpired(entry.timestamp)) {
      return entry.data;
    }

    // If expired or not found, remove and return null
    cache.remove(key);
    return null;
  }

  bool isExpired(DateTime timestamp) {
    return DateTime.now().difference(timestamp) > cacheExpiry;
  }

  void clearExpiredCache() {
    DateTime now = DateTime.now();
    cache.removeWhere((key, entry) => now.difference(entry.timestamp) > cacheExpiry);
    print("Expired cache cleared at ${DateTime.now()}");
  }

  void clearAllCache() {
    cache.clear();
    print("All cache cleared!");
  }

  void dispose() {
    cleanupTimer?.cancel(); // Stop the periodic cleanup timer
  }

  String _generateKey(String plantId, String sensorId) {
    return "$plantId-$sensorId"; // Unique key for each plant-sensor combination
  }
}