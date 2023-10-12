import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  String docId;
  DemoPage(this.docId);
  // const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController demoController = TextEditingController();
  @override
  void initState() {
    print(widget.docId);
    demoController.text = widget.docId.toString();
    FirebaseFirestore.instance
        .collection('books')
        .doc(widget.docId)
        .get()
        .then((value) => {
              demoController.text = value['Bookname'],
            });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: TextFormField(
              controller: demoController,
            ),
          ),
        ),
      ),
    );
  }
}
