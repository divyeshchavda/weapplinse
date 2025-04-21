import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%209/week9.dart';
import 'package:pocketcoach/Week_11/Week11.dart';
import 'package:pocketcoach/Week_12/Week12.dart';
import 'package:pocketcoach/map.dart';


import 'UI/main.dart';
import 'Week 1/week1.dart';
import 'Week 2/week2.dart';
import 'Week 3/week3.dart';
import 'Week 4/week4.dart';
import 'Week 5/week5.dart';
import 'Week 6/week6.dart';
import 'Week 7/week 7.dart';
import 'Week 8/week8.dart';
import 'main.dart';

class week extends StatefulWidget {
  const week({super.key});

  @override
  State<week> createState() => _weekState();
}

class _weekState extends State<week> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForTerminatedNotification();
  }
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

  void go5(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomNavigationBar(),));
  }

  void go6(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week6(),));
  }
  void go7(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week7(),));
  }
  void go8(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week8(),));
  }
  void go9(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => week9(),));
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
          InkWell(
            onTap: go6,
            child: fun("WEEK 6"),
          ),
          InkWell(
            onTap: go7,
            child: fun("WEEK 7"),
          ),
          InkWell(
            onTap: go8,
            child: fun("WEEK 8"),
          ),
          InkWell(
            onTap: go9,
            child: fun("""WEEK
9 & 10"""),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => week11(),));
            },
            child: fun("WEEK 11"),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => week12(),));
            },
            child: fun("WEEK 12"),
          ),
          InkWell(
            onTap: go5,
            child: fun("FIGMA UI"),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => map(),));
            },
            child: fun("MAP"),
          ),
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
