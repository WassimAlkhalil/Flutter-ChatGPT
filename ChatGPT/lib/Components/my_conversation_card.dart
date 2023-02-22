import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyConversationCard extends StatelessWidget {
  final String conversation;
  final bool isUserAsking;

  const MyConversationCard({
    Key? key,
    required this.conversation,
    required this.isUserAsking,
  }) : super(key: key);

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
                    child: isUserAsking
                        ? Container(
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
                          )
                        : Image.asset(
                            'assets/settings.png',
                            width: constraints.maxWidth * 0.08,
                            height: constraints.maxWidth * 0.08,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: isUserAsking
                        ? Text(
                            conversation,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          )
                        : DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  conversation,
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
