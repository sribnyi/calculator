import 'package:decimal/decimal.dart';
import 'package:logger/logger.dart';
import 'package:rational/rational.dart';

class CalculatorModel {
  final Logger logger = Logger();

  String _input = '';
  String _output = '0';
  String _operator = '';

  String get input => _input;

  String get output => _output;

  String get operator => _operator;

  void clear() {
    _input = '';
    _output = '0';
    _operator = '';
  }

  /// new calculate method to support more than two numbers/operators
  void calculate() {
    logger.i(_input);

    /// Regexp filters out operators: '-' subtraction (escaped the '-' symbol
    /// with a '\'), '+' addition, '*' multiplication, '/' division
    List<String> digits = _input.split(RegExp(r'[+\-*/]'));
    logger.i(digits);

    /// RegExp filter out numbers. Range of [0 to 9] followed by a '.' to
    /// include decimal numbers. The '+' to include all preceding matches
    List<String> operators = _input.split(RegExp(r'[0-9.]+')).where(

        /// '(e) => e.isNotEmpty' is shortened from:
        /// bool isNotEmptyFunction(String e) {
        ///   return e.isNotEmpty;
        /// }
        (e) => e.isNotEmpty).toList();

    Decimal result;

    /// first iteration - multiplication and division
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == "*" || operators[i] == "/") {
        Decimal firstNumber = Decimal.parse(digits[i]);
        Decimal secondNumber = Decimal.parse(digits[i + 1]);

        if (operators[i] == "*") {
          result = firstNumber * secondNumber;
        } else {
          /// 'Rational' translates 0.5/45 to 1/90 or 0.23/0.5 to 23/50
          Rational r = firstNumber / secondNumber;
          /// 'Rational' can be parsed to 'Decimal', but needs a
          /// 'scaleOnInfinitePrecision' - trailing numbers after decimal
          result = r.toDecimal(scaleOnInfinitePrecision: 8);
        }

        digits.removeAt(i + 1);
        digits[i] = result.toString();
        operators.removeAt(i);
        /// Adjust the index after removing an element
        i--;
      }
    }

    /// initializing result for the second iteration
    result = Decimal.parse(digits[0]);

    /// second iteration - addition and subtraction
    for (int i = 0; i < operators.length; i++) {
      Decimal nextNumber = Decimal.parse(digits[i + 1]);
      String operator = operators[i];

      switch (operator) {
        case "+":
          result += nextNumber;
          break;
        case "-":
          result -= nextNumber;
          break;
        default:
          break;
      }
    }

    /// showing off out my ternary conditional expression skill
    _output = result.toString();
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

  void setInput(String s) {
    _input = s;
  }

  getOutput() {
    return output;
  }
}
