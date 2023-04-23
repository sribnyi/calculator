class CalculatorModel {
  String _output = "0";
  String _operator = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  String get output => _output;

  void clear() {
    _output = "0";
    _operator = "";
    _num1 = 0.0;
    _num2 = 0.0;
  }

  void setOperator(String operator) {
    _operator = operator;
    _num1 = double.parse(_output);
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

  void addDigit(String digit) {
    if (_output == "0") {
      _output = digit;
    } else {
      _output += digit;
    }
  }
}
