import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-3-1.dart';
import 'package:weapplinse/Week%203/task3-3-2.dart';
import 'package:weapplinse/Week%203/task3-3-4.dart';

class task33 extends StatefulWidget {
  const task33({super.key});

  @override
  State<task33> createState() => _task33State();
}

class _task33State extends State<task33> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3"),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task331(),));
              },
              child: Text("Insert Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ), Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => task332(),));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => task334(),));
              },
              child: Text("Display & EDIT Data",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
      ],),
    );
  }
}
