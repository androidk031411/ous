import 'package:flutter/material.dart';
import 'package:ous/NavBar.dart';
class Eat extends StatelessWidget {
  const Eat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavBar(),
    appBar: AppBar(
      title: Text('食堂'),
    ),
    body: Center(
      child: Column(
        children: [
        Text(
        '食堂一覧',
          textAlign: TextAlign.right,
          style: TextStyle(
          fontSize: 30,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      )        ],
      ),
    ),
  );
}
