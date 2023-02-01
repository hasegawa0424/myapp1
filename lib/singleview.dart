import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SingleView extends StatelessWidget {
  late CollectionReference cref;
  int index;
  late String commentc;
  final editController = TextEditingController();

  SingleView(this.index) {
    cref = FirebaseFirestore.instance.collection('PortfolioApp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleView')),
      body: StreamBuilder<QuerySnapshot>(
        stream: cref.snapshots(),
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
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
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
                          "タイトル:" +
                              snapshot.data!.docs[index]
                                  .get('title')
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Text(
                          "名前:" +
                              snapshot.data!.docs[index].get('name').toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Text(
                          "登録日:" +
                              snapshot.data!.docs[index]
                                  .get('registration date')
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Text(
                          "紹介文:" +
                              snapshot.data!.docs[index]
                                  .get('introduction')
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Column(
                            children: [
                              Text('コメント一覧'),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs[index]
                                    .get('comment')
                                    .length,
                                itemBuilder: (contextC, indexC) {
                                  return Card(
                                      child: Text(snapshot.data!.docs[index]
                                          .get('comment')[indexC]
                                          .toString()));
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: TextField(
                            controller: editController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ここにコメントを入力'),
                            onChanged: (text) {
                              // TODO: ここで取得したtextを使う
                              commentc = text;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            cref.doc(snapshot.data!.docs[index].id).update(
                              {
                                "comment": FieldValue.arrayUnion([commentc]),
                              },
                            );
                            editController.clear();
                            /* ボタンがタップされた時の処理 */
                          },
                          child: Text('コメント追加'),
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
}
