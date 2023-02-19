import 'package:flutter/material.dart';
import '../Authentication/SignIn/signin.dart';
import '../Authentication/SignUp/signup.dart';
import '../Authentication/ResetPassword/reset_password.dart';

class ToggleSignInSignUp extends StatefulWidget {
  const ToggleSignInSignUp({super.key});

  @override
  State<ToggleSignInSignUp> createState() => _ToggleSignInSignUpState();
}

class _ToggleSignInSignUpState extends State<ToggleSignInSignUp> {
  bool showSignIn = true;
  bool showResetPassword = false;

  void toggleScreen(String screen) {
    setState(() {
      switch (screen) {
        case 'SignIn':
          showSignIn = true;
          showResetPassword = false;
          break;
        case 'SignUp':
          showSignIn = false;
          showResetPassword = false;
          break;
        case 'ResetPassword':
          showSignIn = false;
          showResetPassword = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
          showSignUp: () => toggleScreen('SignUp'),
          showResetPassword: () => toggleScreen('ResetPassword'));
    } else if (showResetPassword) {
      return ResetPassword(showSignIn: () => toggleScreen('SignIn'));
    } else {
      return SignUp(showSignIn: () => toggleScreen('SignIn'));
    }
  }
}
