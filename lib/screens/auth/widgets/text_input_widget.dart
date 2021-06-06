import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;
  TextInputField({
    required this.controller,
    required this.hintText,
    this.isPasswordField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            obscureText: isPasswordField,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
