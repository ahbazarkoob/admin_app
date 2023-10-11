// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:admin_app/bookform.dart';
import 'package:admin_app/constants.dart';
import 'package:admin_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'loginform.dart';

TextEditingController recipenamecontroller = TextEditingController();
TextEditingController recipiedesccontroller = TextEditingController();
TextEditingController ingredientscontroller = TextEditingController();
TextEditingController stepscontroller = TextEditingController();

class FormData extends StatefulWidget {
  const FormData({super.key});

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Add New Dish',
              style: kHeading,
            ),
            TextInput(
                hintText: 'Recipie Name', controller: recipenamecontroller),
            TextInput(
                hintText: 'Recipie Description',
                controller: recipiedesccontroller),
            TextInput(
                hintText: 'Ingredients', controller: ingredientscontroller),
            TextInput(hintText: 'Steps', controller: stepscontroller),
            ElevatedButton(
                onPressed: () {
                  String recipieid =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  FirebaseFirestore.instance.collection('Recipies').doc().set({
                    'RID': recipieid,
                    'RecipieName': recipenamecontroller.text,
                    'RecipieDescription': recipiedesccontroller.text,
                    'Ingredients': ingredientscontroller.text,
                    'Steps': stepscontroller.text,
                  }).whenComplete(() => {
                        recipenamecontroller.clear(),
                        recipiedesccontroller.clear(),
                        ingredientscontroller.clear(),
                        stepscontroller.clear(),
                        Alert(
                                context: context,
                                title: 'Recipie Added Successfully')
                            .show()
                      });
                },
                child: Text('Submit'))
          ],
        ),
      ),
    ));
  }
}
