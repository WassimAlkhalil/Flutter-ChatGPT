import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../Components/my_alert_dialog.dart';
import '../../Components/my_text_form_field_email.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.showSignIn});
  final VoidCallback showSignIn;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;

  Future<void> resetPassword(context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: 'Invalid email',
            content: 'Please enter a valid email',
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'User not found',
              content: 'Please enter a valid email',
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
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return isLoading
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: heightScreen * 0.05,
                      width: widthScreen * 0.99,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.showSignIn();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 180.0),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'enter your email address to reset your password',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
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
                    const SizedBox(height: 80.0),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.generalLogin,
                      onPressed: () {
                        resetPassword(context);
                      },
                      text: 'Reset Password',
                      width: widthScreen * 0.89,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          );
  }
}
