// lib/screens/views/currently_view.dart
import 'package:flutter/material.dart';

class CurrentlyView extends StatelessWidget {
  final String location;

  const CurrentlyView({
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        location.isEmpty ? 'Currently' : 'Currently\n$location',
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}