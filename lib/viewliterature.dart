import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewLiteraturePage extends StatefulWidget {
  const ViewLiteraturePage({super.key});

  @override
  State<ViewLiteraturePage> createState() => _ViewLiteraturePageState();
}

class _ViewLiteraturePageState extends State<ViewLiteraturePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
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
              return ListTile(
                title: Text(data['Bookname']),
                subtitle: Text(data['Author']),
              );
            }).toList(),
          );
        });
  }
}
