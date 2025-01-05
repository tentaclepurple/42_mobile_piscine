import 'package:flutter/material.dart';

class WeeklyView extends StatelessWidget {
  final String location;
  final Map<String, dynamic>? weatherData;

  const WeeklyView({
    required this.location,
    this.weatherData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dailyData = weatherData?['daily'];
    final locationParts = location.split(', ');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: locationParts
                .map((part) => Text(
                      part,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ))
                .toList(),
          ),
        ),
        if (dailyData != null)
          Expanded(
            child: ListView.builder(
              itemCount: dailyData['time'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Row(
                    children: [
                      // Fecha
                      SizedBox(
                        width: 100,
                        child: Text(
                          dailyData['time'][index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      // Temperaturas en fila
                      Text(
                        '${dailyData['temperature_2m_min'][index]}°C',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${dailyData['temperature_2m_max'][index]}°C',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      // Descripción del clima
                      Text(
                        getWeatherDescription(dailyData['weather_code'][index]),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return 'Light rain';
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
        return 'Rain';
      case 71:
      case 73:
      case 75:
      case 77:
        return 'Snow';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 85:
      case 86:
        return 'Snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunder with hail';
      default:
        return 'UNKNOWN'; // o podríamos usar 'Clear sky' como valor por defecto
    }
  }
}
