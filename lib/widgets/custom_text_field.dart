import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.obscureText = false,
      required this.textEditingController,
      this.hinttext})
      : super(key: key);
  String? hinttext;
  bool? obscureText;
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'this Field is required';
        }
      },
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
