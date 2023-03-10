import 'dart:async';
import 'package:chatgpt/MainPage/toggle_signin_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() {
    var duration = const Duration(seconds: 2);
    return Timer(
      duration,
      () {
        Navigator.pushReplacement(
          context,
          CupertinoDialogRoute(
            builder: (context) => const ToggleSignInSignUp(),
            context: context,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final heightScreen = constraints.maxHeight;
        final widthScreen = constraints.maxWidth;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/chatbot.json',
                height: heightScreen * 0.4,
                width: widthScreen * 0.4,
                repeat: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
