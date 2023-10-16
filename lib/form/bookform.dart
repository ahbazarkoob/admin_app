// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors, unused_element, unused_local_variable

import 'dart:io';
import 'package:admin_app/constants.dart';
import 'package:admin_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

bool showImage = false;
TextEditingController nameController = TextEditingController();
TextEditingController authorController = TextEditingController();
TextEditingController genreController = TextEditingController();
TextEditingController lengthController = TextEditingController();
TextEditingController langController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController urlController = TextEditingController();

ImagePicker picker = ImagePicker();
File image = File('');
File? imageFile;
String imageURL = "";

class BookFormData extends StatefulWidget {
  List<String> category = ['Poetry', 'Prose', 'History', 'New'];
  String selcategory = 'Poetry';
  BookFormData({super.key});
  @override
  State<BookFormData> createState() => _BookFormDataState();
}

class _BookFormDataState extends State<BookFormData> {
  final formGlobalKey = GlobalKey<FormState>();
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
      imageURL = await referenceImageToUpload.getDownloadURL();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
        title: Text("Add New Book"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Form(
                key: formGlobalKey,
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
                    TextInput(hintText: 'Genre', controller: genreController),
                    TextInput(hintText: 'Length', controller: lengthController),
                    TextInput(hintText: 'Lang', controller: langController),
                    TextInput(hintText: 'Desc', controller: descController),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          validator: ValidationBuilder().url().build(),
                          controller: urlController,
                          decoration: InputDecoration(
                              hintText: 'Enter book url',
                              errorText:
                                  validate ? 'Value Can\'t Be Empty' : null,
                              hintStyle: TextStyle(fontSize: 20),
                              enabledBorder: kBorder,
                              focusedBorder: kBorder)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            String bookId =
                                DateTime.now().microsecondsSinceEpoch.toString();
                            FirebaseFirestore.instance
                                .collection('books')
                                .doc(bookId)
                                .set({
                              'BID': bookId,
                              'Category': widget.selcategory,
                              'Bookname': nameController.text,
                              'Bookimage': imageURL,
                              'Author': authorController.text,
                              'Genre': genreController.text,
                              'Length': lengthController.text,
                              'Language': langController.text,
                              'Description': descController.text,
                              'Link': urlController.text
                            }).whenComplete(() => {
                                      nameController.clear(),
                                      authorController.clear(),
                                      genreController.clear(),
                                      lengthController.clear(),
                                      langController.clear(),
                                      descController.clear(),
                                      urlController.clear(),
                                      setState(() {
                                        showImage = false;
                                      }),
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
      ),
    ));
  }
}
