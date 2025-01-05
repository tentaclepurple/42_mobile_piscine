// lib/screens/views/currently_view.dart
import 'package:flutter/material.dart';

class CurrentlyView extends StatelessWidget {
  final String location;
  final Map<String, dynamic>? weatherData;

  const CurrentlyView({
    required this.location,
    this.weatherData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherData?['current'];
    final locationParts = location.split(', ');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...locationParts.map((part) => Text(
                part,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              )),
          if (currentWeather != null) ...[
            const SizedBox(height: 8),
            Text(
              '${currentWeather['temperature_2m']}°C',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '${currentWeather['wind_speed_10m']} km/h',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ],
      ),
    );
  }
}