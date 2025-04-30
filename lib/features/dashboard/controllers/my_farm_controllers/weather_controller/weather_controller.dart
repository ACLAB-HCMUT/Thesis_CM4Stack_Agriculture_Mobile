// import 'dart:async';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../data/repository/weather/weather_repository.dart';
// import '../../../models/weather_model.dart';
//
// class WeatherController extends GetxController{
//
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;
//   var cityName = ''.obs;
//   var weather = Weather(cityName: '', temperature: 0.0, mainCondition: '').obs;
//   var isLoading = false.obs;
//   var locationStatus = 'Press button to get location'.obs;
//
//   final WeatherRepository weatherRepository = WeatherRepository(apiKey: '119c07ea97df9d6c59b6fe705ea68944');
//
//   WeatherController  get getWeather=>Get.find();
//   var formattedDate=''.obs;
//   late Timer timer;
//
//   void updateTime(){
//     DateTime now = DateTime.now();
//     DateFormat formatter = DateFormat('HH:mm EEE dd MMMM');
//     formattedDate.value = formatter.format(now);  }
//   @override
//   void onInit() {
//     super.onInit();
//     updateTime();
//     getCurrentLocation(); // Automatically fetch location and weather on initialization
//
//     timer=Timer.periodic(Duration(minutes: 1), (timer){
//       updateTime();
//     });
//
//   }
//
//   @override
//   void onClose() {
//       timer.cancel();
//       super.onClose();
//   }
//
//   Future<void> getCurrentLocation() async {
//     isLoading(true);
//     try {
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           locationStatus.value = 'Location permissions are denied';
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         locationStatus.value = 'Location permissions are permanently denied.';
//         return;
//       }
//
//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;
//       locationStatus.value = 'Location retrieved successfully';
//
//       // Fetch weather data using latitude and longitude
//       weather.value = await weatherRepository.getWeather(latitude.value, longitude.value);
//     } catch (e) {
//       locationStatus.value = 'Failed to retrieve location or weather data.';
//     } finally {
//       isLoading(false);
//     }
//   }
//
// }

import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../data/repository/weather/weather_repository.dart';
import '../../../models/weather_model.dart';

class WeatherController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var cityName = ''.obs;
  var weather = Weather(cityName: 'NA', temperature: 0.0, mainCondition: 'NA').obs;
  var isLoading = false.obs;
  var locationStatus = 'Press button to get location'.obs;
  var formattedDate = ''.obs;

  final WeatherRepository weatherRepository = WeatherRepository(apiKey: '119c07ea97df9d6c59b6fe705ea68944');

  late Timer updateTimer; // Timer for updating the date/time every minute
  late Timer locationTimer; // Timer for updating the location every hour

  @override
  void onInit() {

    super.onInit();
    updateTime();
    getCurrentLocation(); // Initial call to fetch location and weather

    // Timer to update time every minute
    updateTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      updateTime();
    });

    // Timer to call getCurrentLocation every hour
    locationTimer = Timer.periodic(Duration(hours: 1), (timer) {
      getCurrentLocation();
    });
  }

  // Method to update the formatted time string
  void updateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('HH:mm EEE dd MMMM');
    formattedDate.value = formatter.format(now);
  }

// Method to get the current location
  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationStatus.value = 'Location services are disabled.';
        return;
      }




      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationStatus.value = 'Location permissions are denied';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationStatus.value = 'Location permissions are permanently denied.';
        return;
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Update the latitude and longitude observables
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      locationStatus.value = 'Location retrieved successfully';

      await getCityName(latitude.value, longitude.value);

      // Optionally, fetch weather data based on the new location
      weather.value = await weatherRepository.getWeather(latitude.value, longitude.value);
    } catch (e) {
      locationStatus.value = 'Failed to retrieve location or weather data.';
    } finally {
      isLoading.value = false;
    }
  }


//   Future<void> getCurrentLocation() async {
//     try {
//       isLoading.value = true;
//
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         locationStatus.value = 'Location services are disabled. Please enable them.';
//         // Prompt user to open location settings if location services are disabled
//         bool openedSettings = await Geolocator.openLocationSettings();
//         if (!openedSettings) {
//           locationStatus.value = 'Please enable location services manually.';
//           return;
//         }
//         // Re-check after opening settings
//         serviceEnabled = await Geolocator.isLocationServiceEnabled();
//         if (!serviceEnabled) {
//           locationStatus.value = 'Location services are still disabled.';
//           return;
//         }
//       }
//
//       // Check location permission status
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           locationStatus.value = 'Location permissions are denied.';
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         locationStatus.value = 'Location permissions are permanently denied.';
//         return;
//       }
//
//       // Fetch the current position
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//       // Update latitude and longitude observables
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;
//       locationStatus.value = 'Location retrieved successfully';
//
//       // Fetch city name based on coordinates (optional)
//       await getCityName(latitude.value, longitude.value);
//
//       // Optionally, fetch weather data based on the new location
//       weather.value = await weatherRepository.getWeather(latitude.value, longitude.value);
//
//     } catch (e) {
//       locationStatus.value = 'Failed to retrieve location or weather data.';
//       print('Error in getCurrentLocation: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
  Future<void> getCityName(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        cityName.value = placemarks[0].administrativeArea ?? 'Unknown City';
      } else {
        cityName.value = 'City not found';
      }
    } catch (e) {
      cityName.value = 'Error retrieving city name.';
    }
  }

  @override
  void onClose() {
    updateTimer.cancel(); // Stop the updateTimer
    locationTimer.cancel(); // Stop the locationTimer
    super.onClose();
  }
}
