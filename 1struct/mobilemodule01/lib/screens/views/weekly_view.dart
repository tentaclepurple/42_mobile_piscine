// lib/screens/views/weekly_view.dart
import 'package:flutter/material.dart';

class WeeklyView extends StatelessWidget {
  final String location;

  const WeeklyView({
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        location.isEmpty ? 'Weekly' : 'Weekly\n$location',
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}