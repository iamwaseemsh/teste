import 'package:flutter/material.dart';
import 'package:weight_app/contants/constants.dart';

class MainElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  MainElevatedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: kSecondaryColor, // background
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: onPressed,
    );
  }
}
