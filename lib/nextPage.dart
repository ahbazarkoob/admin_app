// ignore_for_file: file_names, prefer_const_constructors

import 'package:admin_app/constants.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(child: Text('Welcome',style: kHeading,),),
          ],
        ))
    );
  }
}