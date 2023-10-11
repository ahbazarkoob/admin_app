import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
   File? _imageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        final storage = FirebaseStorage.instance;
        final storageRef = storage.ref().child('images/${_imageFile!}');
        final uploadTask = storageRef.putFile(_imageFile!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_imageFile != null)
                Image.file(_imageFile!),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
            ],
          ),
        ),
      );
  }
}