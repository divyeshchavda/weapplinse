import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-1.dart';
import 'package:weapplinse/Week%203/task3-2.dart';
import 'package:weapplinse/Week%203/task3-3.dart';

class week3 extends StatefulWidget {
  const week3({super.key});

  @override
  State<week3> createState() => _week3State();
}

class _week3State extends State<week3> {
  void go() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task31(),
        ));
  }

  void go1() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task32(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task331(),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 3"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(onTap: go, child: fun("TASK 1")),
          InkWell(
            onTap: go1,
            child: fun("TASK 2"),
          ),
          InkWell(
            onTap: go2,
            child: fun("TASK 3"),
          )
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
