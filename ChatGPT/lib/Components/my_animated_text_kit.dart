import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyAnimatedTextKit extends StatelessWidget {
  const MyAnimatedTextKit(
      {super.key, required this.firstText, required this.secondText});
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          firstText,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.grey,
          ),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          secondText,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.grey,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
    );
  }
}
