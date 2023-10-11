// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:admin_app/constants.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  String hintText = '';
  TextEditingController controller = TextEditingController();
  TextInput({required this.hintText, required this.controller});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 20),
              enabledBorder: kBorder,
              focusedBorder: kBorder)),
    );
  }
}
