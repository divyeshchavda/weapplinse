import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%206/task6-1.dart';
import 'package:pocketcoach/Week%206/task6-2.dart';
import 'package:pocketcoach/Week%206/task6-3.dart';


class week6 extends StatefulWidget {
  const week6({super.key});

  @override
  State<week6> createState() => _week6State();
}

class _week6State extends State<week6> {
  void go() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  task61(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task62(),
        ));
  }
  void go3() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task63(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 6"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(
            onTap: go,
            child: fun("TASK 1"),
          ),
          InkWell(
            onTap: go2,
            child: fun("TASK 2"),
          ),
          InkWell(
            onTap: go3,
            child: fun("TASK 3"),
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
