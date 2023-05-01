import 'package:flutter/material.dart';
import '../model/button_model.dart';
import '../model/calculator_model.dart';
import '../controller/calculator_controller.dart'; // Import CalculatorController

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final _model = CalculatorModel();

  /// declaring an instance of 'CalculatorController', 'late' means that the
  /// variable will be initialized later
  late final CalculatorController controller;

  @override
  void initState() {
    super.initState();

    /// initializing the instance in 'initState'
    controller = CalculatorController(_model);
  }

  String get _output => _model.output;

  Widget _buildButton(String buttonText, ButtonType buttonType) {
    return CalculatorButton(
      buttonText: buttonText,
      buttonType: buttonType,
      onPressed: (value) {
        setState(() {
          controller.buttonPressed(value);
        });
      },
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
