import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CalculatorButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            primary: Colors.grey[400],
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
