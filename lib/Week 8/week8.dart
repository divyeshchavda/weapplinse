import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%207/pay2.dart';
import 'package:pocketcoach/Week%207/task7-1-1-v.dart';
import 'package:pocketcoach/Week%207/task7-1.dart';
import 'package:pocketcoach/Week%207/task7-2.dart';


import 'package:pocketcoach/Week%207/task7-3.dart';
import 'package:pocketcoach/Week%207/task7-4.dart';
import 'package:pocketcoach/Week%208/task8-1.dart';
import 'package:pocketcoach/Week%208/task8-2.dart';
import 'package:pocketcoach/Week%208/task8-3.dart';
import 'package:pocketcoach/Week%208/task8-4.dart';
import 'package:pocketcoach/Week%208/task8-5.dart';
class week8 extends StatefulWidget {
  const week8({super.key});

  @override
  State<week8> createState() => _week8State();
}

class _week8State extends State<week8> {
  List<CameraDescription> cameras=[];

  void go()   {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  task81(),
        ));
  }
  void gov()   {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  task82(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task83(),
        ));
  }
  void go3() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task84(),
        ));
  }
  void go5() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task85(),
        ));
  }
  void go6() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => stripe(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 8"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(
            onTap: go,
            child: fun("TASK 1"),
          ),
          InkWell(
            onTap: gov,
            child: fun("TASK 2"),
          ),
          InkWell(
            onTap: go2,
            child: fun("TASK 3"),
          ),
          InkWell(
            onTap: go3,
            child: fun("TASK 4"),
          ),
          InkWell(
            onTap: go5,
            child: fun("TASK 5"),
          ),
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
