import 'package:flutter/material.dart';
import '../model/calculator_model.dart';

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final _model = CalculatorModel();
  String _output = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _model.clear();
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        _model.setOperator(buttonText);
      } else if (buttonText == ".") {
        _model.addDecimal();
      } else if (buttonText == "=") {
        _model.calculate(); // Call calculate method in CalculatorModel
        _output = _model.output;
        if (_model.input.isNotEmpty && _model.output.isNotEmpty) {
          _model.addToHistory(_model.input,
              _model.output); // Pass input and output to addToHistory
        }
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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'km-mi') {
                Navigator.pushNamed(context, '/converter');
              } else if (value == 'history') {
                Navigator.pushNamed(context, '/history');
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'km-mi',
                child: Text('KM <-> Mile'),
              ),
              const PopupMenuItem<String>(
                value: 'history',
                child: Text('History'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
