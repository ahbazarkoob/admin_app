// ignore_for_file: prefer_const_constructors
import 'package:admin_app/bookform.dart';
import 'package:admin_app/constants.dart';
import 'package:admin_app/editliterature.dart';
import 'package:admin_app/main.dart';
import 'package:admin_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditMainPage extends StatefulWidget {
  String docId;
  EditMainPage(this.docId);

  @override
  State<EditMainPage> createState() => _EditMainPageState();
}

class _EditMainPageState extends State<EditMainPage> {
  TextEditingController categorydesccontroller = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  String networkImage = '';
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('main')
        .doc(widget.docId.toString())
        .get()
        .then((value) => {
              setState(() {
                categorydesccontroller.text = value['CategoryDescription'];
                categoryController.text = value['CategoryName'];
                cidController.text = value['CID'];
                networkImage = value['CategoryImage'];
              })
            });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Center(
        child: Form(
            key: formGlobalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Edit Form',
                      style: kHeading,
                    ),
                  ),
                  EditInput(controller: cidController),
                  Container(
                    height: devW * 0.4,
                    width: devW * 0.3,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, offset: Offset(5, 5))
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                            image: NetworkImage(networkImage),
                            fit: BoxFit.fill)),
                  ),
                  EditInput(controller: categorydesccontroller),
                  ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('main')
                              .doc(widget.docId)
                              .update({
                            'CID': cidController.text,
                            'CategoryName': categoryController.text,
                            'CategoryImage': networkImage,
                            'CategoryDescription': categorydesccontroller.text,
                          }).whenComplete(() => Alert(
                                      context: context,
                                      title: 'Category Updated Successfully')
                                  .show());
                        }
                      },
                      child: Text('Submit'))
                ],
              ),
            )),
      ),
    )));
  }
}
