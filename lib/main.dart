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
      appBar: AppBar(title: Text('Baby Name Votes')),
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

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  child:Text(
                    'Card01',
                    style:TextStyle(
                      fontSize: 50
                    ),
                  ),
                    color:Colors.red,
                    margin: EdgeInsets.all(30),
                    elevation: 10,
                    shadowColor: Colors.red,
              ),
            ],
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
      print(elem.get('votes'));
      print(elem.get('comment'));
      print(elem.get('introduction'));
      print(elem.get('title'));

    });
    print("##################################################### initialize()");
  }
}