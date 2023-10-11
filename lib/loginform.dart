// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'nextPage.dart';

TextEditingController nameController = TextEditingController();
TextEditingController passController = TextEditingController();

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInput(hintText: 'User Name', controller: nameController),
            TextInput(hintText: 'Password', controller: passController),
            IconButton(
                onPressed: () {
                  pickimage();
                },
                icon: Icon(Icons.camera)),
            ElevatedButton(
                onPressed: () {
                  if (nameController.text == 'admin' &&
                      passController.text == 'admin123') {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => NextPage()));
                  } else {
                    print('Wrong Password');
                    Alert(
                      context: context,
                      title: 'Wrong Password',
                      desc: 'You\'ve entered wrong credentials.',
                    ).show();
                  }
                },
                child: Text('Register'))
          ],
        ),
      ),
    ));
  }

  void pickimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference refDirImages = referenceRoot.child('images');
        Reference referenceImageToUpload = refDirImages.child(uniqueFileName);
        final uploadTask = referenceImageToUpload.putFile(_imageFile!);
        final finalURL =
            FirebaseStorage.instance.refFromURL('images/$uniqueFileName');
      });
    }
  }
}

class TextInput extends StatefulWidget {
  String hintText = '';
  TextEditingController controller = TextEditingController();
  TextInput({required this.hintText, required this.controller});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(width: 3)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(width: 3)))),
    );
  }
}
