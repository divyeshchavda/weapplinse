import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%204/task4-1-1.dart';
import 'package:pocketcoach/Week%204/task4-2-1.dart';
import 'package:pocketcoach/Week%204/task4-3.dart';
import 'package:pocketcoach/Week%204/task4-4.dart';
import 'package:pocketcoach/Week%204/task4-5.dart';
import 'package:pocketcoach/Week%204/task4-6.dart';

import 'Pagination.dart';


class week4 extends StatefulWidget {
  const week4({super.key});

  @override
  State<week4> createState() => _week4State();
}

class _week4State extends State<week4> {
  void go() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task411(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task421(),
        ));
  }
  void go3() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task43(),
        ));
  }
  void go4() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task45(),
        ));
  }
  void go5() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task46(),
        ));
  }
  void go6() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task44(),
        ));
  }
  void go7() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginationDemo(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 4"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(onTap: go, child: fun("TASK 1")),
          InkWell(onTap: go2, child: fun("TASK 2")),
          InkWell(onTap: go3, child: fun("TASK 3")),
          InkWell(onTap: go6, child: fun("TASK 4")),
          InkWell(onTap: go4, child: fun("TASK 5")),
          InkWell(onTap: go7, child: fun("Pagination")),
        ],
      ),
    );
  }
  fun(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.001,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black, width: 3),
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent, Colors.white])),
        child: Center(
            child: Text(
              s,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
