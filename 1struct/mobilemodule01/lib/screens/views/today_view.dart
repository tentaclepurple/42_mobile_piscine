// lib/screens/views/today_view.dart
import 'package:flutter/material.dart';

class TodayView extends StatelessWidget {
  final String location;

  const TodayView({
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        location.isEmpty ? 'Today' : 'Today\n$location',
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}