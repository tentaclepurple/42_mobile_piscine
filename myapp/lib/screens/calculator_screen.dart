// lib/screens/calculator_screen.dart
import 'package:flutter/material.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keyboard.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: const Color(0xFF607D8B),
        elevation: 0,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5, // Display área (50%)
              child: CalculatorDisplay(),
            ),
            Expanded(
              flex: 5, // Keyboard área (50%)
              child: CalculatorKeyboard(),
            ),
          ],
        ),
      ),
    );
  }
}