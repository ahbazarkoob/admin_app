// ignore_for_file: prefer_const_constructors
import 'package:admin_app/bookform.dart';
import 'package:admin_app/constants.dart';
import 'package:admin_app/main.dart';
import 'package:admin_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditLiteraturePage extends StatefulWidget {
  String docId;
  EditLiteraturePage(this.docId);

  @override
  State<EditLiteraturePage> createState() => _EditLiteraturePageState();
}

class _EditLiteraturePageState extends State<EditLiteraturePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController langController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController bidController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String networkImage = '';
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('books')
        .doc(widget.docId.toString())
        .get()
        .then((value) => {
              nameController.text = value['Bookname'],
              authorController.text = value['Author'],
              genreController.text = value['Genre'],
              langController.text = value['Language'],
              lengthController.text = value['Length'],
              descController.text = value['Description'],
              urlController.text = value['Link'],
              bidController.text = value['BID'],
              categoryController.text = value['Category'],
              networkImage = value['Bookimage'],
            });
    print(imageController.text);
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
                  EditInput(controller: nameController),
                  EditInput(controller: authorController),
                  EditInput(controller: bidController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: ValidationBuilder().url().build(),
                        controller: imageController,
                        decoration: InputDecoration(
                            enabledBorder: kBorder, focusedBorder: kBorder)),
                  ),
                  EditInput(controller: categoryController),
                  EditInput(controller: descController),
                  EditInput(controller: genreController),
                  EditInput(controller: langController),
                  EditInput(controller: lengthController),
                  Container(
                    height: devW * 0.4,
                    width: devW * 0.3,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 5, offset: Offset(5, 5))
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                            image: NetworkImage(networkImage),
                            fit: BoxFit.fill)),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //       validator: ValidationBuilder().url().build(),
                  //       controller: urlController,
                  //       decoration: InputDecoration(
                  //           enabledBorder: kBorder, focusedBorder: kBorder)),
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('books')
                              .doc(widget.docId)
                              .update({
                            'BID': bidController.text,
                            'Category': categoryController.text,
                            'Bookname': nameController.text,
                            'Bookimage': imageController.text,
                            'Author': authorController.text,
                            'Genre': genreController.text,
                            'Length': lengthController.text,
                            'Language': langController.text,
                            'Description': descController.text,
                            'Link': urlController.text
                          }).whenComplete(() => Alert(
                                      context: context,
                                      title: 'Book Updated Successfully')
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

class EditInput extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  EditInput({required this.controller});

  @override
  State<EditInput> createState() => _EditInputState();
}

class _EditInputState extends State<EditInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        decoration:
            InputDecoration(focusedBorder: kBorder, enabledBorder: kBorder),
      ),
    );
  }
}
