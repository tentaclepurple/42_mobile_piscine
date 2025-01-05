import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city.dart';

class GeocodingService {
  static const String baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

  Future<List<City>> searchCities(String query) async {
    // Validar que la consulta no sea solo caracteres especiales o repetidos
    final RegExp validQuery = RegExp(r'^(?!\s*$)[a-zA-Z\s-]+$');
    if (!validQuery.hasMatch(query)) {
      return [];
    }

    if (query.length < 2) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl?name=$query&count=5&language=en&format=json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && (data['results'] as List).isNotEmpty) {
          final cities = (data['results'] as List)
              .map((city) => City.fromJson(city))
              .toList();
          
          // Filtrar resultados que coincidan más exactamente
          return cities.where((city) {
            final cityName = city.name.toLowerCase();
            final searchQuery = query.toLowerCase();
            return cityName.startsWith(searchQuery) || 
                   cityName.contains(searchQuery);
          }).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error searching cities: $e');
      return [];
    }
  }
}