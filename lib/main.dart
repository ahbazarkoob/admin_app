// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:admin_app/bookform.dart';
import 'package:admin_app/demopage.dart';
import 'package:admin_app/recipieform.dart';
import 'package:admin_app/viewliterature.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MainPage(),
  ));
}

var devH, devW, button;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    devH = MediaQuery.of(context).size.height;
    devW = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SelectionButton(ViewLiteraturePage(), 'View Literature Page'),
          SelectionButton(BookFormData(), 'Add Book'),
          SelectionButton(RecipeFormData(), 'Add Recipie'),
          SelectionButton(DemoPage(), 'Demo')
        ],
      ),
    ));
  }

  Widget SelectionButton(var nextPage, String text) {
    return OutlinedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));
        },
        child: Text(text));
  }
}
