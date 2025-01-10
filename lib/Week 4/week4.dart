import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%204/task4-1.dart';

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
          builder: (context) => task41(),
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
