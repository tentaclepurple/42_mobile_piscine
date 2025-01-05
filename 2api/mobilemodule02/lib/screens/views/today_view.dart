// lib/screens/views/today_view.dart
import 'package:flutter/material.dart';

class TodayView extends StatelessWidget {
  final String location;
  final Map<String, dynamic>? weatherData;

  const TodayView({
    required this.location,
    this.weatherData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hourlyData = weatherData?['hourly'];
    final locationParts = location.split(', ');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: locationParts.map((part) => Text(
                  part,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                )).toList(),
          ),
        ),
        if (hourlyData != null)
          Expanded(
            child: ListView.builder(
              itemCount: 24,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          '${index.toString().padLeft(2, '0')}:00',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '${hourlyData['temperature_2m'][index]}°C',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          '${hourlyData['wind_speed_10m'][index]}km/h',
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 14),
                        ),
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
}