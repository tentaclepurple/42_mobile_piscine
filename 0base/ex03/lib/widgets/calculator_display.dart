// lib/widgets/calculator_display.dart
import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    return Container(
      color: const Color(0xFF455A64),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: isLandscape ? 8.0 : 16.0,  // Menos padding vertical en landscape
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: isLandscape ? 8 : 16),  // Menos espacio en landscape
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              expression.isEmpty ? '0' : expression,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 28 : 32,  // Texto más pequeño en landscape
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLandscape ? 28 : 32,  // Texto más pequeño en landscape
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}