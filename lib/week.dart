import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week 1//week1.dart';
import 'package:weapplinse/Week%202/week2.dart';
import 'package:weapplinse/Week%203/week3.dart';
import 'package:weapplinse/Week%205/week5.dart';

import 'Week 4/week4.dart';

class week extends StatefulWidget {
  const week({super.key});

  @override
  State<week> createState() => _weekState();
}

class _weekState extends State<week> {
  void go() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => week1(),
        ));
  }
  void go1(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week2(),));
  }
  void go2(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week3(),));
  }
  void go3(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week4(),));
  }
  void go4(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week5(),));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("WEEKS"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(
            onTap: go,
            child: fun("WEEK 1"),
          ),
          InkWell(
            onTap: go1,
            child: fun("WEEK 2"),
          ),
          InkWell(
            onTap: go2,
            child: fun("WEEK 3"),
          ),
          InkWell(
            onTap: go3,
            child: fun("WEEK 4"),
          ),
          InkWell(
            onTap: go4,
            child: fun("WEEK 5"),
          ),
          fun("WEEK 6"),
          fun("WEEK 7"),
          fun("WEEK 8"),
          fun("WEEK 9"),
          fun("WEEK 10"),
          fun("WEEK 11"),
          fun("WEEK 12"),
        ],
      ),
    );
  }

  fun(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent, Colors.white])),
        child: Center(
            child: Text(
          s,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
