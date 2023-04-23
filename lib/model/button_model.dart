import 'package:flutter/material.dart';

enum ButtonType {
  number,
  operator,
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final ButtonType buttonType;
  final Function(String) onPressed;

  const CalculatorButton({
    Key? key,
    required this.buttonText,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: () => onPressed(buttonText),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: buttonType == ButtonType.operator
                ? Colors.orange
                : Colors.grey[400],
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
}
