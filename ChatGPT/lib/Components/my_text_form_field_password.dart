import 'package:flutter/material.dart';

class MyTextFormFieldPassword extends StatefulWidget {
  const MyTextFormFieldPassword({
    Key? key,
    required this.controller,
    required this.showProgress,
  }) : super(key: key);

  final TextEditingController controller;
  final bool showProgress;

  @override
  State<MyTextFormFieldPassword> createState() =>
      _MyTextFormFieldPasswordState();
}

class _MyTextFormFieldPasswordState extends State<MyTextFormFieldPassword> {
  int passwordStrength = 0;
  bool showProgress = false;
  bool isObSecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FocusScope(
          onFocusChange: (hasFocus) {
            setState(() {
              showProgress = hasFocus;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            obscureText: isObSecure,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must be at least 8 characters long.';
              } else if (value.length > 20) {
                return 'Password must be no longer than 20 characters.';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                passwordStrength = value.length;
              });
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.grey),
              hintText: 'Enter your password',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObSecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObSecure = !isObSecure;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        widget.showProgress == true && showProgress == true
            ? Container(
                width: 150,
                height: 6.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: passwordStrength / 20,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        passwordStrength >= 12 ? Colors.green : Colors.red),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
