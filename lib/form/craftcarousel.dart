// ignore_for_file: unnecessary_set_literal

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import '../widgets/textfield.dart';

class CraftCarousel extends StatefulWidget {
  CraftCarousel({super.key});
  @override
  State<CraftCarousel> createState() => _CraftCarouselState();
}

class _CraftCarouselState extends State<CraftCarousel> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(),
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Add New Craft Category',
                    style: kHeading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  TextInput(hintText: 'Title', controller: nameController),
                  TextInput(hintText: 'Title Description', controller: authorController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Upload Image',
                        style: kSubHeading,
                      ),
                      IconButton(
                          onPressed: () {
                            pickimage();
                            showImage = true;
                          },
                          icon: Icon(Icons.camera)),
                    ],
                  ),
                  !showImage
                      ? Text('Image not selected')
                      : SizedBox(
                          height: 100,
                          width: 200,
                          child: Image.file(imageFile!),
                        ),
                  TextInput(hintText: 'History', controller: genreController),
                  TextInput(hintText: 'HistoryDesc', controller: lengthController),
                  TextInput(hintText: 'Process', controller: langController),
                  TextInput(hintText: 'ProcessDesc', controller: descController),
                  
                  ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          String CarouselId =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          FirebaseFirestore.instance
                              .collection('craftcarousel')
                              .doc(CarouselId)
                              .set({
                            'BID': CarouselId,
                          }).whenComplete(() => {
                                    Alert(
                                            context: context,
                                            title: 'Book Added Successfully')
                                        .show()
                                  });
                        }
                      },
                      child: Text('Submit'))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
