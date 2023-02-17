import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Components/my_elevated_button.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<String> conversations = [];

  void addConversation() {
    setState(
      () {
        conversations.add('new conversation');
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: SafeArea(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final heightScreen = MediaQuery.of(context).size.height;
              final widthScreen = MediaQuery.of(context).size.width;

              return Column(
                children: [
                  // NEW CHAT BUTTON AND LIST OF CONVERSATIONS
                  SizedBox(
                    height: heightScreen * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: heightScreen * 0.03,
                          child: Text(
                            'Hello, ${FirebaseAuth.instance.currentUser?.displayName ?? 'Guest'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          height: heightScreen * 0.05,
                          width: widthScreen * 0.5,
                          child: MyElevatedButton(
                            onPressed: addConversation,
                            text: 'new conversation',
                            textColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            leading: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // DIVIDER
                  const Divider(
                    thickness: 0.5,
                  ),
                  // LIST OF CONVERSATIONS WITH SLIDABLE ACTIONS AND TEXT FORM FIELD TO EDIT CONVERSATION NAME
                  SizedBox(
                    height: heightScreen * 0.5,
                    child: ListView.builder(
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final name = conversations[index];
                        return ListTile(
                          title: Slidable(
                            key: Key(name),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  onPressed: deleteConversation,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              initialValue: name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  conversations[index] = value;
                                });
                              },
                            ),
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                  // DIVIDER
                  const Divider(
                    thickness: 0.5,
                  ),
                  // CLEAR CONVERSATIONS
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text(
                      'clear conversations',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        conversations.clear();
                      });
                    },
                  ),
                  // LOGOUT BUTTON
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'logout',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/splash',
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
