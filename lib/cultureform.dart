// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:admin_app/constants.dart';
import 'package:admin_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

TextEditingController culturenamecontroller = TextEditingController();
TextEditingController culturedesccontroller = TextEditingController();

class CultureFormData extends StatefulWidget {
  const CultureFormData({super.key});

  @override
  State<CultureFormData> createState() => _CultureFormDataState();
}

class _CultureFormDataState extends State<CultureFormData> {
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
              'Add New Destination',
              style: kHeading,
            ),
            TextInput(
                hintText: 'Culture Name', controller: culturenamecontroller),
            TextInput(
                hintText: 'Culture Description',
                controller: culturedesccontroller),
            ElevatedButton(
                onPressed: () {
                  String destinationId =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  FirebaseFirestore.instance
                      .collection('Destinations')
                      .doc()
                      .set({
                    'DID': destinationId,
                    'DestinationName': culturenamecontroller.text,
                    'DestinationDescription': culturedesccontroller.text,
                  }).whenComplete(() => {
                            culturenamecontroller.clear(),
                            culturedesccontroller.clear(),
                            Alert(
                                    context: context,
                                    title: 'Destination Added Successfully')
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
