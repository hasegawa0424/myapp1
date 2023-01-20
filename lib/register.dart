import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatelessWidget {
  late CollectionReference cref;
  String? data_title;
  String? data_name;
  String? data_registration_date;
  String? data_introduction;
  String? data_imageURL;

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
                // Ink.image(
                //   image: NetworkImage(
                //     data_imageURL ?? '',
                //   ),
                //   height: 240,
                //   fit: BoxFit.contain,
                // ),
                OutlinedButton(onPressed: () async {
                  await addPicture();
                }, child: Text('写真選択')),
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
                        'imageURL': data_imageURL ?? '',
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

  Future<void> addPicture() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      final User user = FirebaseAuth.instance.currentUser!;

      // Storageに登録
      final int timestamp = DateTime.now().microsecondsSinceEpoch;
      final File file = File(result.files.single.path!);
      final String name = file.path.split('/').last;
      final String path = '${timestamp}_$name';
      final TaskSnapshot task = await FirebaseStorage.instance
          .ref()
          .child('portfolio')
          .child(path)
          .putFile(file);

      // Firestoreに登録
      data_imageURL = await task.ref.getDownloadURL();
    }
  }
}
