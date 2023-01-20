import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Register extends StatelessWidget {
  late CollectionReference cref;
  String? data_title;
  String? data_name;
  String? data_registration_date;
  String? data_introduction;

  Register() {
    cref = FirebaseFirestore.instance.collection('baby');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('register')),
      body: StreamBuilder<QuerySnapshot>(
        stream: cref.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                OutlinedButton(onPressed: () {}, child: Text('写真選択')),
                Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ここにタイトルを入力'),
                      onChanged: (text) {
                        // TODO: ここで取得したtextを使う
                        data_title = text;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ここに名前を入力'),
                      onChanged: (text) {
                        // TODO: ここで取得したtextを使う
                        data_name = text;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ここに登録日を入力'),
                      onChanged: (text) {
                        // TODO: ここで取得したtextを使う
                        data_registration_date = text;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ここに紹介文を入力'),
                      onChanged: (text) {
                        // TODO: ここで取得したtextを使う
                        data_introduction = text;
                      }),
                ),
                OutlinedButton(
                    onPressed: () async {
                      final data = {
                        'comment': <String>[],
                        'imageURL': 'https://booth.pximg.net/57d05e9d-0336-44a8-8ef7-9e5c58a9f641/i/2994358/a467d0db-3ed5-4a38-a158-4a122ae94d81_base_resized.jpg',
                        'introduction': data_introduction ?? '',
                        'name': data_name ?? '',
                        'registration date': data_registration_date ?? '',
                        'title': data_title ?? '',
                      };
                      await FirebaseFirestore.instance
                          .collection('baby')
                          .doc()
                          .set(data);
                    },
                    child: Text('登録')),
              ],
            ),
          );
        },
      ),
    );
  }
}
