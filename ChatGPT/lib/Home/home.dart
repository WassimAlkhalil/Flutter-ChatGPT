import 'package:chatgpt/API/open_ai.dart';
import 'package:chatgpt/Components/my_conversation_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Components/my_chat_input_field.dart';
import '../Model/message.dart';
import 'mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> conversations = [];

  bool isWaitingForResponse = false; // new flag

  bool iconBool = false;

  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;

  void changeIcon() {
    setState(
      () {
        iconBool = !iconBool;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR IS USED TO ADD A NAVIGATION BAR AT THE TOP OF THE SCREEN
      appBar: AppBar(
        title: const Text('ChatGPT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/signout.png',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            );
          },
        ),
      ),
      // DRAWER IS USED TO ADD A SIDEBAR

      body: SafeArea(
        // THIS COLUMN IS USED TO ADD A LISTVIEW AND A TEXTFIELD
        child: Column(
          children: [
            // FLEXIBLE IS USED TO MAKE THE LISTVIEW SCROLLABLE
            Flexible(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return MyConversationCard(
                        conversation: conversations[index],
                        isUserAsking: index % 2 == 0,
                      );
                    },
                  );
                },
              ),
            ),
            if (isWaitingForResponse) // show spinner if waiting for response
              const SpinKitThreeBounce(
                color: Colors.grey,
                size: 20.0,
              ),
            // MYCHATINPUTFIELD IS USED TO ADD A TEXTFIELD AND A SEND BUTTON
            MyChatInputField(
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  setState(() {
                    conversations.add(value);
                    isWaitingForResponse = true; // set flag to true
                  });
                  setState(() async {
                    Message responseMessage = await callOpenAPI(value);
                    setState(() {
                      conversations.add(responseMessage.text);
                      isWaitingForResponse = false; // set flag back to false
                    });
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
