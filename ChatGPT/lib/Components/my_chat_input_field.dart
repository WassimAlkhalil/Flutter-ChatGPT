import 'package:flutter/material.dart';

class MyChatInputField extends StatefulWidget {
  const MyChatInputField({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);
  final Function(String) onSubmitted;

  @override
  State<MyChatInputField> createState() => _MyChatInputFieldState();
}

class _MyChatInputFieldState extends State<MyChatInputField> {
  final TextEditingController textEditingController = TextEditingController();

  final send = Image.asset(
    'assets/send.png',
    width: 25.0,
    height: 25.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 10,
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: IconButton(
                  icon: send,
                  onPressed: () {
                    widget.onSubmitted(textEditingController.text);
                    textEditingController.clear();
                  },
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (text) {
                widget.onSubmitted(text);
                textEditingController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
