import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:thinktaktic/Home/home.dart';
import 'package:thinktaktic/Services/google_service.dart';

import '../../Components/my_alert_dialog.dart';
import '../../Components/my_animated_text_kit.dart';
import '../../Components/my_text_form_field_email.dart';
import '../../Components/my_text_form_field_password.dart';
import '../ResetPassword/reset_password.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.showSignUp}) : super(key: key);
  final VoidCallback showSignUp;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future signin(context) async {
    setState(
      () {
        isLoading = true;
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'User not found',
              content: 'User not found, please try another email',
            );
          },
        );
      }
      if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'Wrong password',
              content: 'Wrong password, please try again',
            );
          },
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ADAPTIVE UI FOR DIFFERENT SCREEN SIZES
    return LayoutBuilder(
      builder: (context, constraints) {
        final heightScreen = constraints.maxHeight;
        final widthScreen = constraints.maxWidth;
        return isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.grey,
                  value: 0.25,
                ),
              )
            : Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                  height: heightScreen * 0.99,
                  width: widthScreen * 0.99,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40.0,
                          child: MyAnimatedTextKit(
                            firstText: 'welcome back !',
                            secondText: 'sign in to continue ...',
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: MyTextFormFieldEmail(
                            // Connected to the emailController for email input
                            controller: emailController,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: MyTextFormFieldPassword(
                            // Connected to the passwordController for password input
                            controller: passwordController,
                            showProgress: false,
                          ),
                        ),
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: MyAnimatedToggleSwitch(),
                            ),
                          ],
                        ),
                        */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "forgot password?" in grey color with bold font
                            const Text(
                              'forgot your password ?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // "click here" in blue color with bold font
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const ResetPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'click here',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.generalLogin,
                          onPressed: () {
                            signin(context);
                          },
                          width: widthScreen * 0.89,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "forgot password?" in grey color with bold font
                            const Text(
                              'Not a member?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // "click here" in blue color with bold font
                            TextButton(
                              onPressed: widget.showSignUp,
                              child: const Text(
                                'sign up',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 0.5, color: Colors.grey),
                        const SizedBox(height: 40.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialLoginButton(
                              buttonType: SocialLoginButtonType.google,
                              onPressed: () {
                                AuthService().signInWithGoogle(context);
                              },
                              width: widthScreen * 0.89,
                            ),
                            const SizedBox(height: 20.0),
                            SocialLoginButton(
                              buttonType: SocialLoginButtonType.apple,
                              onPressed: () {},
                              width: widthScreen * 0.89,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
