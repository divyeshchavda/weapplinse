import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%205/sign.dart';
import 'package:pocketcoach/Week%205/task5-1.dart';
import 'package:pocketcoach/Week%205/task5-2.dart';

class week5 extends StatefulWidget {
  const week5({super.key});

  @override
  State<week5> createState() => _week5State();
}

class _week5State extends State<week5> {
  void go() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task51(),
        ));
  }
  void go2() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => task52(),
        ));
  }
  void go3() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => sign(),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 5"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          InkWell(onTap: go , child: fun("TASK 1")),
          InkWell(onTap: go2 , child: fun("TASK 2")),
          InkWell(onTap: go3 , child: fun("TASK 3")),
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
