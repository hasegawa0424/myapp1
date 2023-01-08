import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SingleView extends StatelessWidget {
  List<DocumentSnapshot> documentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleView')),
      body: FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: documentList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Ink.image(
                      image: NetworkImage(
                        documentList[index].get('imageURL').toString(),
                      ),
                      height: 240,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16).copyWith(bottom: 0),
                      child: Text(
                        documentList[index].get('title').toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16).copyWith(bottom: 0),
                      child: Text(
                        documentList[index].get('name').toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16).copyWith(bottom: 0),
                      child: Text(
                        documentList[index].get('registration date').toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16).copyWith(bottom: 0),
                      child: Text(
                        documentList[index].get('introduction').toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16).copyWith(bottom: 0),
                      child: Text(
                        documentList[index].get('comment').toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> initialize() async {
    final snapshot = await FirebaseFirestore.instance.collection('baby').get();
    documentList = snapshot.docs;

    print("##################################################### initialize()");
    documentList.forEach((elem) {
      print(elem.get('name'));
      print(elem.get('registration date'));
      print(elem.get('comment'));
      print(elem.get('introduction'));
      print(elem.get('title'));
    });
    print("##################################################### initialize()");
  }
}
