import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:logger/logger.dart';

class CalculatorModel {
  final Logger logger = Logger();

  String _input = '';
  String _output = '0';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operator = '';

  String get input => _input;

  String get output => _output;

  double get num1 => _num1;

  double get num2 => _num2;

  String get operator => _operator;

  void clear() {
    _input = '';
    _output = '0';
    _num1 = 0.0;
    _num2 = 0.0;
    _operator = '';
  }

  void setOperator(String operator) {
    _num1 = double.parse(_output);
    _operator = operator;
    _input = '$_num1 $operator ';
    _output = "0";
  }

  void addDecimal() {
    if (!_output.contains(".")) {
      _output += ".";
    }
  }

  /// new calculate method to support more than two numbers/operators
  void calculate() {
    /// Regexp filters out operators: '-' subtraction (escaped the '-' symbol
    /// with a '\'), '+' addition, '*' multiplication, '/' division
    List<String> digits = _input.split(RegExp(r'[+\-*/]'));

    /// RegExp filter out numbers. Range of [0 to 9] followed by a '.' to
    /// include decimal numbers. The '+' to include all preceding matches
    List<String> operators = _input.split(RegExp(r'[0-9.]+'));

    /// removing the first element of the operators list if it's empty
    if (operators.isNotEmpty && operators.first.isEmpty) {
      operators.removeAt(0);
    }

    double result = double.parse(digits[0]);


    for (int i = 0; i < operators.length; i++) {
      switch (operators[i]) {
        case "+":
          result += double.parse(digits[i + 1]);
          break;
        case "-":
          result -= double.parse(digits[i + 1]);
          break;
        case "*":
          result *= double.parse(digits[i + 1]);
          break;
        case "/":
          result /= double.parse(digits[i + 1]);
          break;
        default:
          break;
      }
    }

    _output = result.toString();

    logger.d(digits.toString());
    logger.d(operators.toString());
  }

  void addToHistory(String input, String output) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('history') ?? [];

      final historyItem = {
        'input': input,
        'output': output,
        'timestamp': DateTime.now().toIso8601String(),
      };

      history.add(jsonEncode(historyItem));
      prefs.setStringList('history', history);
    } catch (e) {
      if (kDebugMode) {
        print("Error saving history: $e");
      }
    }
  }

  void appendToInput(String value) {
    if (_output == "0" && value != ".") {
      _output = value;
    } else {
      _output += value;
    }
    _input += value;
  }

  void clearInput() {
    _input = "";
  }
}
