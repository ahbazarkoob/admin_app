// ignore_for_file: prefer_const_constructors

import 'package:admin_app/demopage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('main').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return MainTile(
                  category: data['CategoryName'].toString(),
                  description: data['CategoryDescription'],
                  imagePath: data['CategoryImage']);
            }).toList(),
          );
        });
  }
}

class MainTile extends StatelessWidget {
  final String category;
  final String description;
  final String imagePath;

  MainTile(
      {required this.category,
      required this.description,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12.0), // Adjust the radius as needed
        ),
        elevation: 4,
        child: ListTile(
          title: Row(
            children: [
              Text('Category'),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => DemoPage()));
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: devW * 0.4,
                width: devW * 0.3,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5, offset: Offset(5, 5))],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1),
                    image: DecorationImage(
                        image: NetworkImage(imagePath), fit: BoxFit.fill)),
              ),
              Text("CategoryName: $category"),
              Text(
                "Description: $description",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
