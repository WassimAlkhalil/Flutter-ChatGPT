import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:social_login_buttons/social_login_buttons.dart';

import '../../Components/my_alert_dialog.dart';
import '../../Components/my_animated_text_kit.dart';
import '../../Components/my_text_form_field_email.dart';
import '../../Components/my_text_form_field_password.dart';
import '../../MainPage/verify_email.dart';
import '../../Services/google_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.showSignIn}) : super(key: key);
  final VoidCallback showSignIn;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final image = Image.asset('assets/hidden.png');

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signup(context) async {
    setState(
      () {
        isLoading = true;
      },
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const VerifyEmail(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'Email already in use',
              content: 'Email already in use, please try another email',
            );
          },
        );
      }
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'Weak password',
              content: 'Password should be at least 8 characters',
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // H: 932.0 x W: 430.0
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
                            firstText: 'good decision !',
                            secondText: 'sign up to continue ...',
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
                            showProgress: true,
                          ),
                        ),
                        const SizedBox(height: 88.0),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.generalLogin,
                          onPressed: () {
                            signup(context);
                          },
                          text: 'sign up',
                          width: widthScreen * 0.89,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "forgot password?" in grey color with bold font
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // "click here" in blue color with bold font
                            TextButton(
                              onPressed: widget.showSignIn,
                              child: const Text(
                                'sign in ',
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
