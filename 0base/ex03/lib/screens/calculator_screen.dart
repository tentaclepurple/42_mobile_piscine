// lib/screens/calculator_screen.dart
import 'package:flutter/material.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keyboard.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  static const int MAX_DIGITS = 16;
  String _expression = '';
  String _result = '0';
  bool _hasError = false;
  bool _canAddOperator = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (_hasError) {
        _expression = '';
        _result = '0';
        _hasError = false;
        _canAddOperator = false;
      }

      switch (value) {
        case 'C':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
            _canAddOperator = _expression.isNotEmpty && RegExp(r'[0-9]$').hasMatch(_expression);
          }
          break;
        case 'AC':
          _expression = '';
          _result = '0';
          _canAddOperator = false;
          break;
        case '=':
          if (_expression.isNotEmpty && _canAddOperator) {
            try {
              _calculateResult();
              _canAddOperator = true;
            } catch (e) {
              _hasError = true;
              _result = 'Error';
              _canAddOperator = false;
            }
          }
          break;
        default:
          if (_isValidInput(value)) {
            _expression += value;
            if (RegExp(r'[0-9]$').hasMatch(value)) {
              _canAddOperator = true;
            } else if (RegExp(r'[\+\-×\/]$').hasMatch(value)) {
              _canAddOperator = false;
            }
          }
      }

      if (_expression.isEmpty) {
        _result = '0';
        _canAddOperator = false;
      }
    });
  }

bool _isValidInput(String value) {
  if (_expression.isEmpty) {
    // Allow minus sign as first character
    return RegExp(r'[0-9\-]').hasMatch(value);
  }

  String lastChar = _expression[_expression.length - 1];

  // For operators
  if (RegExp(r'[\+\-×\/]').hasMatch(value)) {
    // Allow minus sign after another operator
    if (value == '-') {
      return true; 
    }
    return RegExp(r'[0-9]$').hasMatch(_expression);  // Other operators require a number before them
  }

  // For numbers
  if (RegExp(r'[0-9]').hasMatch(value)) {
    if (_expression.length >= MAX_DIGITS) return false;
    return true;
  }

  // For decimal point
  if (value == '.') {
    if (!RegExp(r'[0-9]$').hasMatch(_expression)) return false;
    return !_hasDecimalPoint();
  }

  return false;
}

  bool _hasDecimalPoint() {
    int lastOperatorIndex = _expression.lastIndexOf(RegExp(r'[\+\-×\/]'));
    String currentNumber = _expression.substring(lastOperatorIndex + 1);
    return currentNumber.contains('.');
  }

  void _calculateResult() {
  try {
    List<String> tokens = _tokenizeExpression();
    double result = _evaluateTokens(tokens);
    
    if (result.abs() > 1e16) {
      _result = 'Number too large';
      _hasError = true;
      return;
    }
    
    // Corregir el formateo del resultado
    _result = result.toString();
    // Si es un número entero, quitar el ".0"
    if (_result.endsWith('.0')) {
      _result = _result.substring(0, _result.length - 2);
    }
    
  } catch (e) {
    _hasError = true;
    _result = 'Error';
  }
}

  List<String> _tokenizeExpression() {
    List<String> tokens = [];
    String currentNumber = '';
    bool isNegative = false;

    for (int i = 0; i < _expression.length; i++) {
      String char = _expression[i];
      
      if (RegExp(r'[\+×\/]').hasMatch(char) || 
          (char == '-' && i > 0 && !RegExp(r'[\+×\/\-]$').hasMatch(_expression[i-1]))) {
        if (currentNumber.isNotEmpty || isNegative) {
          tokens.add(isNegative ? '-$currentNumber' : currentNumber);
          currentNumber = '';
          isNegative = false;
        }
        tokens.add(char);
      } else if (char == '-' && (i == 0 || RegExp(r'[\+×\/\-]$').hasMatch(_expression[i-1]))) {
        isNegative = true;
      } else {
        currentNumber += char;
      }
    }
    
    if (currentNumber.isNotEmpty || isNegative) {
      tokens.add(isNegative ? '-$currentNumber' : currentNumber);
    }

    return tokens;
  }

  double _evaluateTokens(List<String> tokens) {
  if (tokens.isEmpty) return 0;

  // Multiply and divide first
  for (int i = 1; i < tokens.length - 1; i += 2) {
    if (tokens[i] == '×' || tokens[i] == '/') {
      double a = double.parse(tokens[i - 1]);
      double b = double.parse(tokens[i + 1]);
      double result;
      
      if (tokens[i] == '×') {
        result = a * b;
      } else {
        if (b == 0) throw Exception('Division by zero');
        result = a / b;
      }
      
      tokens[i - 1] = result.toString();
      tokens.removeRange(i, i + 2);
      i -= 2;
    }
  }

  // Add and subtract later
  double result = double.parse(tokens[0]);
  for (int i = 1; i < tokens.length - 1; i += 2) {
    double b = double.parse(tokens[i + 1]);
    if (tokens[i] == '+') {
      result += b;
    } else if (tokens[i] == '-') {
      result -= b;
    }
  }

  return result;
}

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: CalculatorDisplay(
                expression: _expression,
                result: _result,
              ),
            ),
            Expanded(
              flex: 5,
              child: CalculatorKeyboard(
                onButtonPressed: _onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}