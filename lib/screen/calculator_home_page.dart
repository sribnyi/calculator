import 'package:flutter/material.dart';
import '../model/button_model.dart';
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
      switch (buttonText) {
        case "C":
          _model.clear();
          break;
        case "+":
        case "-":
        case "*":
        case "/":
          _model.setOperator(buttonText);
          break;
        case ".":
          _model.addDecimal();
          break;
        case "=":
          _model.calculate(); // call the calculate method in CalculatorModel
          _output = _model.output;
          if (_model.input.isNotEmpty && _model.output.isNotEmpty) {
            _model.addToHistory(
                _model.input, _model.output); // pass I/O to addToHistory
          }
          break;
        default:
          _model.addDigit(buttonText);
      }
      _output = _model.output;
    });
  }

  Widget _buildButton(String buttonText, ButtonType buttonType) {
    return CalculatorButton(
      buttonText: buttonText,
      buttonType: buttonType,
      onPressed: _buttonPressed,
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
                _buildButton('7', ButtonType.number),
                _buildButton('8', ButtonType.number),
                _buildButton('9', ButtonType.number),
                _buildButton('/', ButtonType.operator),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildButton('4', ButtonType.number),
                _buildButton('5', ButtonType.number),
                _buildButton('6', ButtonType.number),
                _buildButton('*', ButtonType.operator),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildButton('1', ButtonType.number),
                _buildButton('2', ButtonType.number),
                _buildButton('3', ButtonType.number),
                _buildButton('-', ButtonType.operator),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildButton('.', ButtonType.operator),
                _buildButton('0', ButtonType.number),
                _buildButton('00', ButtonType.number),
                _buildButton('+', ButtonType.operator),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                _buildButton('C', ButtonType.operator),
                _buildButton('=', ButtonType.operator),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
