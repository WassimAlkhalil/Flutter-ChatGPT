import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/my_chat_input_field.dart';
import '../Drawer/drawer.dart';
import 'mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> conversations = [];

  void addConversation() {
    setState(
      () {
        conversations.add('New conversation');
      },
    );
  }

  void deleteConversation(BuildContext context) {
    setState(
      () {
        conversations.removeAt(conversations.length - 1);
      },
    );
  }

  bool iconBool = false;

  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;

  void changeIcon() {
    setState(() {
      iconBool = !iconBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR IS USED TO ADD A NAVIGATION BAR AT THE TOP OF THE SCREEN
      appBar: AppBar(
        title: const Text('ChatGPT'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(iconBool ? Icons.wb_sunny : Icons.nights_stay,
                color: iconBool ? Colors.yellow : Colors.white),
            onPressed: () {
              Mode().changeTheme();
              changeIcon();
            },
          ),
        ],
      ),
      // DRAWER IS USED TO ADD A SIDEBAR
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FLEXIBLE IS USED TO MAKE THE LISTVIEW SCROLLABLE
            Flexible(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Material(
                        child: Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    conversations[index],
                                    style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.04,
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
                },
              ),
            ),
            // MYCHATINPUTFIELD IS USED TO ADD A TEXTFIELD AND A SEND BUTTON
            MyChatInputField(
              onSubmitted: (text) {
                setState(
                  () {
                    conversations.add(text);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
