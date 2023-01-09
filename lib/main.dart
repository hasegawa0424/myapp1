import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'singleview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PortfolioApp')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('baby').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          print(
              "##################################################### initialize()");
          snapshot.data!.docs.forEach((elem) {
            print(elem.get('name'));
            print(elem.get('registration date'));
            print(elem.get('comment'));
            print(elem.get('introduction'));
            print(elem.get('title'));
          });
          print(
              "##################################################### initialize()");
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SingleView(index)),
                  );
                  /*タップ処理*/
                },
                child: Card(
                  child: Column(
                    children: [
                      Ink.image(
                        image: NetworkImage(
                          snapshot.data!.docs[index].get('imageURL').toString(),
                        ),
                        height: 240,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Text(
                          snapshot.data!.docs[index].get('title').toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
