import 'package:flutter/material.dart';

/// enum of the type of a button for readability/safety
enum ButtonType {
  number,
  operator,
}

class CalculatorButton extends StatelessWidget {
  /// text that appears on the button e.g. a number or operator
  final String buttonText;

  /// type of the button - number/operator
  final ButtonType buttonType;

  final Function(String) onPressed;

  /// creating constant value of 'CalculatorButton' at compile-time
  const CalculatorButton({
    /// optional key parameter of type 'Key'. Question mark means it is nullable
    Key? key,

    /// the following three parameters MUST BE provided
    required this.buttonText,
    required this.buttonType,
    required this.onPressed,

    /// ': super(key: key)' passes the 'key' parameter to our superclass
    /// StatelessWidget, which the 'CalculatorButton' extends
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Creates a widget that expands a child of a [Row], [Column], or [Flex]
    /// so that the child fills the available space along the flex widget's
    /// main axis.
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          /// 'onPressed' - a named parameter for the 'ElevatedButton' widget
          /// '()' - defines an anonymous function with no parameters
          /// '=>' - a shortcut to define the function with a single expression
          /// 'onPressed(buttonText)' - function call to the 'onPressed'
          /// function passed as a required parameter to the 'CalculatorButton'
          /// widget. 'buttonText' variable is passed as an argument to this
          /// function.
          onPressed: () => onPressed(buttonText),
          style: ElevatedButton.styleFrom(
            /// sets the foreground color of the button to black
            foregroundColor: Colors.black,

            /// if the 'buttonType' is 'operator'
            backgroundColor: buttonType == ButtonType.operator

                /// then the 'backgroundColor' is 'orange'
                ? Colors.orange

                /// else, the 'backgroundColor' is 'grey'
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
