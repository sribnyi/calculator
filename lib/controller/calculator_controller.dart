import '../model/calculator_model.dart';

class CalculatorController {
  final CalculatorModel _model;

  CalculatorController(this._model);

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
        _model.addDecimal();
        break;
      case "=":
        _model.calculate();
        if (_model.input.isNotEmpty && _model.output.isNotEmpty) {
          _model.addToHistory(_model.input, _model.output);
        }
        _model.clearInput(); // Clear the input after the calculation
        break;
      default:
        _model.appendToInput(buttonText);
    }
    // return _model.output;
  }
}
