import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/calculator_model.dart';

class CalculatorController {
  final Logger logger = Logger();
  final CalculatorModel _model;

  CalculatorController(this._model);

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
      logger.e(e);
    }
  }

  void buttonPressed(String buttonText) {
    switch (buttonText) {
      case "C":
        _model.clear();
        break;
      case "+":
      case "-":
      case "*":
      case "/":
        _model.appendToInput(buttonText);
        break;
      case ".":
        _model.appendToInput(buttonText);
        break;
      case "=":
        _model.calculate();
        if (_model.input.isNotEmpty && _model.output.isNotEmpty) {
          addToHistory(_model.input, _model.output);
        }

        /// Clear the input after the calculation
        _model.clearInput();
        break;
      default:
        _model.appendToInput(buttonText);
    }
  }
}
