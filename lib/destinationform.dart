// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:admin_app/bookform.dart';
import 'package:admin_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'loginform.dart';

TextEditingController destinationnamecontroller = TextEditingController();
TextEditingController destinationdesccontroller = TextEditingController();

class DestinationFormData extends StatefulWidget {
  const DestinationFormData({super.key});

  @override
  State<DestinationFormData> createState() => _DestinationFormDataState();
}

class _DestinationFormDataState extends State<DestinationFormData> {
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
                hintText: 'Destination Name',
                controller: destinationnamecontroller),
            TextInput(
                hintText: 'Destination Description',
                controller: destinationdesccontroller),
            ElevatedButton(
                onPressed: () {
                  String destinationId =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  FirebaseFirestore.instance
                      .collection('Destinations')
                      .doc()
                      .set({
                    'DID': destinationId,
                    'DestinationName': destinationnamecontroller.text,
                    'DestinationDescription': destinationdesccontroller.text,
                  }).whenComplete(() => {
                            destinationnamecontroller.clear(),
                            destinationdesccontroller.clear(),
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
