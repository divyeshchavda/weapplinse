import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%201/task1.dart';
import 'package:weapplinse/Week%201/task2.dart';
import 'package:weapplinse/Week%201/task3.dart';
import 'package:weapplinse/Week%201/task4.dart';
import 'package:weapplinse/Week%201/task5.dart';
import 'package:weapplinse/Week%201/task6.dart';
import 'package:weapplinse/Week%201/task7.dart';

class week1 extends StatefulWidget {
  const week1({super.key});

  @override
  State<week1> createState() => _week1State();
}

class _week1State extends State<week1> {
  void go(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task1(),));
  }
  void go1(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task2(),));
  }
  void go2(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task3(),));
  }
  void go3(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task4(),));
  }
  void go4(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task5(),));
  }
  void go5(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task6(),));
  }
  void go6(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task7(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 1"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [InkWell(onTap: go, child: fun("TASK 1")),
          InkWell(onTap: go1, child: fun("TASK 2")),
          InkWell(onTap: go2, child: fun("TASK 3")),
          InkWell(onTap: go3, child: fun("TASK 4")),
          InkWell(onTap: go4, child: fun("TASK 5")),
          InkWell(onTap: go5, child: fun("TASK 6")),
          InkWell(onTap: go6, child: fun("TASK 7")),
        ],
      ),
    );
  }

  fun(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.001,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black, width: 3),
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent, Colors.white])),
        child: Center(
            child: Text(
              s,
              style: TextStyle(
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .width * 0.06,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
