import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%207/pay2.dart';
import 'package:pocketcoach/Week%207/task7-1-1-v.dart';
import 'package:pocketcoach/Week%207/task7-1.dart';
import 'package:pocketcoach/Week%207/task7-2.dart';


import 'package:pocketcoach/Week%207/task7-3.dart';
import 'package:pocketcoach/Week%207/task7-4.dart';
import 'inbuilt.dart';

class week7 extends StatefulWidget {
  const week7({super.key});

  @override
  State<week7> createState() => _week7State();
}

class _week7State extends State<week7> {
  List<CameraDescription> cameras=[];

void go()   {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  task711(),
        ));
  }
  void gov()   {

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  task711v(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task712(),
        ));
  }
  void go3() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task713(),
        ));
  }
  void go4() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePickerExample(),
        ));
  }
  void go5() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task714(),
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
        title: Text("WEEK 7"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(
            onTap: go,
            child: fun("""TASK 1
(Image)"""),
          ),
          InkWell(
            onTap: gov,
            child: fun("""TASK 1
(Video)"""),
          ),
          InkWell(
            onTap: go2,
            child: fun("TASK 2"),
          ),
          InkWell(
            onTap: go3,
            child: fun("TASK 3"),
          ),
          InkWell(
            onTap: go5,
            child: fun("TASK 4"),
          ),
          InkWell(
            onTap: go4,
            child: fun("INBUILT"),
          ),
          InkWell(
            onTap: go6,
            child: fun("Stripe"),
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
