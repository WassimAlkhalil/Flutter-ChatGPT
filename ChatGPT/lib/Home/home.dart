import 'package:chatgpt/API/open_ai.dart';
import 'package:chatgpt/Components/my_conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Components/my_chat_input_field.dart';
import '../Drawer/drawer.dart';
import '../Model/message.dart';
import 'mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> conversations = [];

  final isTyping = false;

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
                          conversation: conversations[index]);
                    },
                  );
                },
              ),
            ),

            if (isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.grey,
                size: 20.0,
              ),
            ],
            // MYCHATINPUTFIELD IS USED TO ADD A TEXTFIELD AND A SEND BUTTON
            MyChatInputField(
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  setState(() {
                    conversations.add(value);
                  });
                  Message responseMessage = await callOpenAPI(value);
                  setState(() {
                    conversations.add(responseMessage.text);
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
