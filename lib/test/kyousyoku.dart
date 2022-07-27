import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ous/main.dart';
import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'image_page.dart';
import 'firebase_api.dart';
import 'firebase_file.dart';



class kyousyoku extends StatefulWidget {
  const kyousyoku({Key? key}) : super(key: key);

  @override
  State<kyousyoku> createState() => _kyousyokuState();
}

class _kyousyokuState extends State<kyousyoku> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('教職科目/');
  }

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('教職科目'),
    ),
    body: FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.do_disturb_on_outlined,size: 150,),
                      Text(
                        '校外のメールアドレスでログインしているため\nこの機能は利用できません。',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )

              );
            } else {
              final files = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files.length),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) =>Card(
      child: ListTile(
          leading: Icon(Icons.photo),
          trailing: Icon(Icons.chevron_right),
          title: Text(
            file.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImagePage(file: file),
          ),
          ))
  );


  Widget buildHeader(int length) => ListTile(
    tileColor: Colors.lightGreen,
    leading: Container(
      width: 52,
      height: 52,
      child: Icon(
        Icons.file_copy,
        color: Colors.white,
      ),
    ),
    title: Text(
      '$length 個の過去問があります',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
