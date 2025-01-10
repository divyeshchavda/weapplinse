import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task73 extends StatefulWidget {
  const task73({super.key});

  @override
  State<task73> createState() => _task73State();
}

class _task73State extends State<task73> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Page 3"),
    ),
    body:
    Center(child: Column(
    children: [
    ElevatedButton(onPressed: () {
    Navigator.pop(context);
    }, child: Text("POP-Page #")),
    ],
    )));
  }
}
