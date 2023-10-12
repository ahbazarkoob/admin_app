// ignore_for_file: file_names, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: TextFormField(
        controller: controller,
      ),
    ));
  }
}
