// lib/widgets/calculator_keyboard.dart
import 'package:flutter/material.dart';
import 'calculator_button.dart';

class CalculatorKeyboard extends StatelessWidget {
  final Function(String) onButtonPressed;

  const CalculatorKeyboard({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF607D8B),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = constraints.maxHeight / 4;  // Altura dividida por 4 filas
          return Column(
            children: [
              SizedBox(
                height: buttonSize,
                child: Row(
                  children: [
                    _buildButtonExpanded('7'),
                    _buildButtonExpanded('8'),
                    _buildButtonExpanded('9'),
                    _buildButtonExpanded('C', isSpecial: true),
                    _buildButtonExpanded('AC', isSpecial: true),
                  ],
                ),
              ),
              SizedBox(
                height: buttonSize,
                child: Row(
                  children: [
                    _buildButtonExpanded('4'),
                    _buildButtonExpanded('5'),
                    _buildButtonExpanded('6'),
                    _buildButtonExpanded('+', isOperator: true),
                    _buildButtonExpanded('-', isOperator: true),
                  ],
                ),
              ),
              SizedBox(
                height: buttonSize,
                child: Row(
                  children: [
                    _buildButtonExpanded('1'),
                    _buildButtonExpanded('2'),
                    _buildButtonExpanded('3'),
                    _buildButtonExpanded('×', isOperator: true),
                    _buildButtonExpanded('/', isOperator: true),
                  ],
                ),
              ),
              SizedBox(
                height: buttonSize,
                child: Row(
                  children: [
                    _buildButtonExpanded('0'),
                    _buildButtonExpanded('.'),
                    _buildButtonExpanded('00'),
                    _buildButtonExpanded('=', isOperator: true),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButtonExpanded(String text, {bool isOperator = false, bool isSpecial = false}) {
    return Expanded(
      child: CalculatorButton(
        text: text,
        onPressed: () => onButtonPressed(text),
        isOperator: isOperator,
        isSpecial: isSpecial,
      ),
    );
  }
}