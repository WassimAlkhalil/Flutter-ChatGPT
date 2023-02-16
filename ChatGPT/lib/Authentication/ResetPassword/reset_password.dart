import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../Components/my_alert_dialog.dart';
import '../../Components/my_animated_text_kit.dart';
import '../../Components/my_text_form_field_email.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    bool isLoading = false;

    Future resetPassword(context) async {
      setState(
        () {
          isLoading = true;
        },
      );
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        showDialog(
          context: context,
          builder: (context) {
            return const MyAlertDialog(
              title: 'Email sent',
              content: 'Email sent, please check your email',
            );
          },
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
                        const SizedBox(height: 50.0),
                        const SizedBox(
                          height: 40.0,
                          child: MyAnimatedTextKit(
                            firstText: 'forgot your password ?',
                            secondText: 'no problem, we got you !',
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
      },
    );
  }
}
