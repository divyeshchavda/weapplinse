import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-2-1.dart';
import 'package:weapplinse/Week%203/task3-2-2.dart';
import 'package:weapplinse/Week%203/task3-2-3.dart';
import 'package:weapplinse/Week%203/task3-2-4.dart';

class task32 extends StatefulWidget {
  const task32({super.key});

  @override
  State<task32> createState() => _task32State();
}

class _task32State extends State<task32> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2"),
      ),
      body:ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task321(),));
              },
              child: Text("Insert Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task322(),));
              },
              child: Text("Update Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task323(),));
              },
              child: Text("Delete Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task324(),));
              },
              child: Text("Display Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
      ],),
    );
  }
}
