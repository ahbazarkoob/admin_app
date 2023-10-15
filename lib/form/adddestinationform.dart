// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import '../widgets/textfield.dart';
import 'bookform.dart';

String destimageURL = '';
TextEditingController destdesccontroller = TextEditingController();
TextEditingController destnamecontroller = TextEditingController();

class DestinationFormData extends StatefulWidget {
  @override
  State<DestinationFormData> createState() => _DestinationFormDataState();
}

class _DestinationFormDataState extends State<DestinationFormData> {
  List<String> category = [
    'Wildlife',
    'Shrines',
    'Treks',
    'Pilgrims',
    'Heritage Sites'
  ];
  String selcategory = 'Wildlife';
  pickimage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload = refDirImages.child(uniqueFileName);
      final uploadTask = await referenceImageToUpload.putFile(imageFile!);
      destimageURL = await referenceImageToUpload.getDownloadURL();
    }
  }

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formGlobalKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Add Destination',
                      style: kHeading,
                    ),
                    Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Category'),
                          DropdownButton(
                            focusColor: Colors.blue,
                            items: category.map((String category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                  style: kNormalTextBold,
                                ),
                              );
                            }).toList(),
                            value: selcategory,
                            onChanged: (String? newvalue) {
                              setState(() {
                                selcategory = newvalue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextInput(
                        hintText: 'Destination Name',
                        controller: destnamecontroller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
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
                        : Container(
                            height: 100,
                            width: 200,
                            child: Image.file(imageFile!),
                          ),
                    TextInput(
                        hintText: 'Destination Description',
                        controller: destdesccontroller),
                    ElevatedButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            String DestinationId = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            FirebaseFirestore.instance
                                .collection('destination')
                                .doc(DestinationId)
                                .set({
                              'DestId': DestinationId,
                              'DestName': destnamecontroller.text,
                              'DestCategory': selcategory,
                              'DestImage': destimageURL,
                              'DestDescription': destdesccontroller.text,
                            }).whenComplete(() => {
                                      destnamecontroller.clear(),
                                      destdesccontroller.clear(),
                                      Alert(
                                              context: context,
                                              title:
                                                  'Destination Added Successfully')
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
      ),
    ));
  }
}
