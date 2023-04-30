import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalculatorModel {
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
    _input = '$_num1 $operator '; // Update input with the operator and num1
    _output = "0";
  }

  void addDecimal() {
    if (!_output.contains(".")) {
      _output += ".";
    }
  }

  void calculate() {
    _num2 = double.parse(_output);
    switch (_operator) {
      case "+":
        _output = (_num1 + _num2).toString();
        break;
      case "-":
        _output = (_num1 - _num2).toString();
        break;
      case "*":
        _output = (_num1 * _num2).toString();
        break;
      case "/":
        _output = (_num1 / _num2).toString();
        break;
      default:
        break;
    }
    _operator = "";
    _num1 = 0.0;
    _num2 = 0.0;
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

  void addDigit(String digit) {
    if (_output == "0") {
      _output = digit;
    } else {
      _output += digit;
    }
    _input += digit; // Update input with the digit
  }
}
