import 'package:calculator/screen/calculator_home_page.dart';
import 'package:calculator/screen/history_screen.dart';
import 'package:flutter/material.dart';

import 'screen/convert_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorHomePage(),
        '/converter': (context) => const ConverterScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
