import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyConversationCard extends StatelessWidget {
  final String conversation;

  const MyConversationCard({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: constraints.maxWidth * 0.08,
                      height: constraints.maxWidth * 0.08,
                      color: Colors.blue[700],
                      child: Center(
                        child: Text(
                          '${FirebaseAuth.instance.currentUser?.displayName?[0]}',
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            conversation,
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                            ),
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
