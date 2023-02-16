import 'package:flutter/material.dart';

// CLASS SIGNINBUTTON
class MySignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;
  final double width;
  final double height;

  // CONSTRUCTOR
  const MySignInButton({
    super.key,
    required this.onPressed,
    required this.assetName,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            assetName,
            width: width * 0.5,
          ),
        ),
      ),
    );
  }
}
