import 'dart:convert';

import '../../../features/dashboard/models/weather_model.dart';

import 'package:http/http.dart' as http;


class WeatherRepository {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherRepository({required this.apiKey});

  // Method to fetch weather by latitude and longitude
  Future<Weather> getWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
