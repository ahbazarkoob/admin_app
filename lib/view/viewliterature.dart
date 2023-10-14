import 'package:admin_app/edit/editliterature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';

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
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return MyListTile(
                bookName: data['Bookname'],
                author: data['Author'],
                id: data['BID'],
                image: data['Bookimage'],
                category: data['Category'],
                description: data['Description'],
                genre: data['Genre'],
                language: data['Language'],
                length: data['Length'],
                url: data['Link'],
              );
            }).toList(),
          );
        });
  }
}

class MyListTile extends StatelessWidget {
  final String bookName;
  final String author;
  final String genre;
  final String length;
  final String language;
  final String description;
  final String url;
  final String image;
  final String category;
  final String id;

  const MyListTile(
      {super.key,
      required this.bookName,
      required this.author,
      required this.genre,
      required this.category,
      required this.description,
      required this.id,
      required this.image,
      required this.language,
      required this.length,
      required this.url});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('LITERATURE'),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditLiteraturePage(id)));
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Author:$author"),
              Text("Genre: $genre"),
              Text("Language: $language"),
              Text("Length: $length"),
              Text("Id: $id"),
              Text("Name: $bookName"),
              Text("Image: $url"),
              Container(
                height: devW * 0.4,
                width: devW * 0.3,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(blurRadius: 5, offset: Offset(5, 5))
                    ],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.fill)),
              ),
              Text(
                "Description: $description",
                textAlign: TextAlign.justify,
              ),
              Text("Category: $category"),
            ],
          ),
        ),
      ),
    );
  }
}