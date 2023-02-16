import 'package:flutter/material.dart';

import '../Authentication/SignIn/signin.dart';
import '../Authentication/SignUp/signup.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showSignIn = true;
  void toogleScreen() {
    setState(
      () {
        showSignIn = !showSignIn;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(showSignUp: toogleScreen);
    } else {
      return SignUp(showSignIn: toogleScreen);
    }
  }
}
