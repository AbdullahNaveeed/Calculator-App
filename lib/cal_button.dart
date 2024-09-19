import 'package:flutter/material.dart';

class CalButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPress;
  const CalButton(
      {super.key,
      required this.buttonText,
      this.buttonColor = const Color(0xffafafaf),
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: 48,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Color.fromARGB(255, 251, 244, 244), fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
