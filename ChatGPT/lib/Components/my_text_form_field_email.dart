import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class MyTextFormFieldEmail extends StatefulWidget {
  const MyTextFormFieldEmail({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<MyTextFormFieldEmail> createState() => _MyTextFormFieldEmailState();
}

class _MyTextFormFieldEmailState extends State<MyTextFormFieldEmail> {
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateEmail);
  }

  void _validateEmail() {
    setState(() {
      _validate = !validator.email(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email,
          color: Colors.grey,
        ),
        hintText: 'Enter your Email',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: !_validate ? Colors.green : Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
