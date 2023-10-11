// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:admin_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'loginform.dart';

TextEditingController nameController = TextEditingController();
TextEditingController authorController = TextEditingController();
TextEditingController genreController = TextEditingController();
TextEditingController lengthController = TextEditingController();
TextEditingController langController = TextEditingController();
TextEditingController descController = TextEditingController();

class FormData extends StatefulWidget {
  List<String> category = ['Poetry', 'Prose', 'History', 'New'];
  String selcategory = 'Poetry';
  FormData({super.key});

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Add New Book',
                style: kHeading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Select Category',
                    style: kSubHeading,
                  ),
                  DropdownButton(
                    focusColor: Colors.blue,
                    items: widget.category.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: kNormalTextBold,
                        ),
                      );
                    }).toList(),
                    value: widget.selcategory,
                    onChanged: (String? newvalue) {
                      setState(() {
                        widget.selcategory = newvalue!;
                      });
                    },
                  ),
                ],
              ),
              TextInput(hintText: 'Title', controller: nameController),
              TextInput(hintText: 'Author', controller: authorController),
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
                      },
                      icon: Icon(Icons.camera)),
                ],
              ),
              TextInput(hintText: 'Genre', controller: genreController),
              TextInput(hintText: 'Length', controller: lengthController),
              TextInput(hintText: 'Lang', controller: langController),
              TextInput(hintText: 'Desc', controller: descController),
              ElevatedButton(
                  onPressed: () {
                    print(URL);
                    String bookId =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    FirebaseFirestore.instance.collection('books').doc().set({
                      'BID': bookId,
                      'Category': widget.selcategory,
                      'Bookname': nameController.text,
                      'Bookimage': URL,
                      'Author': authorController.text,
                      'Genre': genreController.text,
                      'Length': lengthController.text,
                      'Language': langController.text,
                      'Description': descController.text
                    }).whenComplete(() => {
                          nameController.clear(),
                          authorController.clear(),
                          genreController.clear(),
                          lengthController.clear(),
                          langController.clear(),
                          descController.clear(),
                          Alert(
                                  context: context,
                                  title: 'Book Added Successfully')
                              .show()
                        });
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    ));
  }

  String URL = '';
  void pickimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload = refDirImages.child(uniqueFileName);
      final uploadTask = await referenceImageToUpload.putFile(_imageFile!);
      String imageURL = await referenceImageToUpload.getDownloadURL();
      setState(() {
        URL = imageURL;
        print(URL);
      });
    }
  }
}
