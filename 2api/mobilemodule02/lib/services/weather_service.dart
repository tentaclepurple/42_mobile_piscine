// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> getWeather(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl?latitude=$latitude&longitude=$longitude'
          '&hourly=temperature_2m,wind_speed_10m'
          '&daily=temperature_2m_max,temperature_2m_min,weather_code'
          '&current=temperature_2m,wind_speed_10m'
          '&timezone=auto'
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load weather data');
    } catch (e) {
      throw Exception('Error getting weather: $e');
    }
  }
}