import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
  List<DocumentSnapshot> documentList = [];
  // List<String> name = [];
  // List<int> votes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PortfolioApp')),
      body: FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          // // 通信中はスピナーを表示
          // if (snapshot.connectionState != ConnectionState.done) {
          //   return CircularProgressIndicator();
          // }

          // // エラー発生時はエラーメッセージを表示
          // if (snapshot.hasError) {
          //   return Text(snapshot.error.toString());
          // }

          // // データがnullでないかチェック
          // if (!snapshot.hasData) {
          //   return Text("データが存在しません");
          // }

          // documentList.forEach((elem) {
          //   name.add(elem.get('name'));
          //   votes.add(elem.get('votes'));
          // });
          // return Column(
          //   children: <Widget> [
          //     Text(name[0] + ':' + votes[0].toString()),
          //     Text(name[1] + ':' + votes[1].toString()),
          //   ],

          return SingleChildScrollView(
            child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            documentList[0].get('imageURL').toString(),
                          ),
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            documentList[0].get('title').toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            documentList[0].get('name').toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            documentList[0].get('registration date').toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            documentList[0].get('introduction').toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            documentList[0].get('comment').toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://www.amgakuin.co.jp/contents/common/image/course/cg-design/top/pc_mainImg1.jpg',
                          ),
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            'The cat is the only domesticated species in the family Felidae and is often referred to as the domestic cat to distinguish it from the wild members of the family.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                            'https://booth.pximg.net/57d05e9d-0336-44a8-8ef7-9e5c58a9f641/i/2994358/a467d0db-3ed5-4a38-a158-4a122ae94d81_base_resized.jpg',
                          ),
                          height: 240,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Text(
                            'The cat is the only domesticated species in the family Felidae and is often referred to as the domestic cat to distinguish it from the wild members of the family.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          );
        },
      ),
    );
  }

  Future<void> initialize() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('baby').get();
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