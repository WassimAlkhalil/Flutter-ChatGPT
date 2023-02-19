import 'dart:convert';
import 'package:chatgpt/API/key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../Model/message.dart';

Future<Message> callOpenAPI(String text) async {
  const String url = 'https://api.openai.com/v1/completions';
  final Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $key",
  };

  final body = json.encode({
    "model": "text-davinci-003",
    "prompt": text,
    "max_tokens": 200,
    "temperature": 0
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return Message(
          text: data['choices'][0]['text'],
          sender: FirebaseAuth.instance.currentUser!.displayName!,
          time: DateTime.now().toString());
    } else {
      return Message(
          text: "Error Occured !",
          sender: FirebaseAuth.instance.currentUser!.displayName!,
          time: DateTime.now().toString());
    }
  } catch (e) {
    return Message(
        text: "Error Occured !",
        sender: FirebaseAuth.instance.currentUser!.displayName!,
        time: DateTime.now().toString());
  }
}
