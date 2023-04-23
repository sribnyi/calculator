import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'calculator_model.dart';

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final _model = CalculatorModel(); // create an instance of the CalculatorModel class
  String _output = "0";
  final String _operator = "";
  final double _num1 = 0.0;
  double _num2 = 0.0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _model.clear();
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" ||
          buttonText == "/") {
        _model.setOperator(buttonText);
      } else if (buttonText == ".") {
        _model.addDecimal();
      } else if (buttonText == "=") {
        _model.calculate();
      } else {
        _model.addDigit(buttonText);
      }
      _output = _model.output;
    });
  }

  Widget _buildNumberButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[400],
            shape: const CircleBorder(),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.orange,
            shape: const CircleBorder(),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
                horizontal: 24.0, vertical: 12.0),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                _buildOperatorButton('/'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                _buildOperatorButton('*'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                _buildOperatorButton('-'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildOperatorButton('.'),
                _buildNumberButton('0'),
                _buildNumberButton('00'),
                _buildOperatorButton('+'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildOperatorButton('C'),
                _buildOperatorButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }
}