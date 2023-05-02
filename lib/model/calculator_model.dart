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

  // /// new calculate method to support more than two numbers/operators
  // void calculate() {
  //   logger.i(_input);
  //
  //   /// Regexp filters out operators: '-' subtraction (escaped the '-' symbol
  //   /// with a '\'), '+' addition, '*' multiplication, '/' division
  //   List<String> digits = _input.split(RegExp(r'[+\-*/]'));
  //
  //   /// RegExp filter out numbers. Range of [0 to 9] followed by a '.' to
  //   /// include decimal numbers. The '+' to include all preceding matches
  //   List<String> operators =
  //       _input.split(RegExp(r'[0-9.]+')).where((e) => e.isNotEmpty).toList();
  //
  //   /// removing the first element of the operators list if it's empty
  //   double result = double.parse(digits[0]);
  //
  //   for (int i = 0; i < operators.length; i++) {
  //     double nextNumber = double.parse(digits[i + 1]);
  //     String operator = operators[i];
  //
  //     switch (operator) {
  //       case "+":
  //         result += nextNumber;
  //         break;
  //       case "-":
  //         result -= nextNumber;
  //         break;
  //       case "*":
  //         result *= nextNumber;
  //         break;
  //       case "/":
  //         result /= nextNumber;
  //         break;
  //       default:
  //         break;
  //     }
  //   }

  /// new calculate method to support more than two numbers/operators
  void calculate() {
    logger.i(_input);

    /// Regexp filters out operators: '-' subtraction (escaped the '-' symbol
    /// with a '\'), '+' addition, '*' multiplication, '/' division
    List<String> digits = _input.split(RegExp(r'[+\-*/]'));

    /// RegExp filter out numbers. Range of [0 to 9] followed by a '.' to
    /// include decimal numbers. The '+' to include all preceding matches
    List<String> operators =
        _input.split(RegExp(r'[0-9.]+')).where((e) => e.isNotEmpty).toList();

    /// removing the first element of the operators list if it's empty
    Decimal result = Decimal.parse(digits[0]);

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
        case "*":
          result *= nextNumber;
          break;
        case "/":
          logger.i(result / nextNumber);
          Rational r = result / nextNumber;
          result = r.toDecimal(scaleOnInfinitePrecision: 8);
          break;
        default:
          break;
      }
    }

    /// showing off out my ternary conditional expression skill
    _output = result.toString();
    logger.i(digits.toString());
    logger.i(operators.toString());
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
