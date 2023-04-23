import 'package:flutter/material.dart';
import 'calculator_home_page.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      home: CalculatorHomePage(),
    );
  }
}
