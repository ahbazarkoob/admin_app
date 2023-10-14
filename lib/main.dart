// ignore_for_file: prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:admin_app/form/bookform.dart';
import 'package:admin_app/demopage.dart';
import 'package:admin_app/form/handicraftsform.dart';
import 'package:admin_app/form/mainPageform.dart';
import 'package:admin_app/form/recipieform.dart';
import 'package:admin_app/view/viewhandicrafts.dart';
import 'package:admin_app/view/viewliterature.dart';
import 'package:admin_app/view/viewmain.dart';
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
          SelectionButton(MainCategoryPage(), 'View Main Page'),
          SelectionButton(ViewLiteraturePage(), 'View Literature Page'),
          SelectionButton(ViewHandicraftPage(), 'View Handicraft Page'),
          SelectionButton(BookFormData(), 'Add Book'),
          SelectionButton(RecipeFormData(), 'Add Recipie'),
          SelectionButton(HandicraftFormData(), 'Add Craft'),
          SelectionButton(MainFormData(), 'Add Category'),
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
