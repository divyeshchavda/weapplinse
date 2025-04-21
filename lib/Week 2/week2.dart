import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%202/task2-1.dart';
import 'package:pocketcoach/Week%202/task2-2.dart';
import 'package:pocketcoach/Week%202/task2-3.dart';
import 'package:pocketcoach/Week%202/task2-4.dart';


class week2 extends StatefulWidget {
  const week2({super.key});

  @override
  State<week2> createState() => _week2State();
}

class _week2State extends State<week2> {
  void go(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task21(),));
  }
  void go1(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task22(),));
  }
  void go2(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task23(),));
  }
  void go3(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => task24(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 2"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [InkWell(onTap: go, child: fun("TASK 1")),
          InkWell(onTap: go1, child: fun("TASK 2")),
          InkWell(onTap: go2, child: fun("TASK 3")),
          InkWell(onTap: go3, child: fun("TASK 4")),
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
