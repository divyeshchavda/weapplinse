import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task2242 extends StatefulWidget {
  const task2242({super.key});

  @override
  State<task2242> createState() => _task2242State();
}

class _task2242State extends State<task2242> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2 (Grid Widget)"),
      ),
      body: GridView.count(crossAxisCount: 2,children: [
        fun("1"),
        fun("2"),
        fun("3"),
        fun("4"),
        fun("5"),
        fun("6"),
        fun("7"),
        fun("8"),
        fun("9"),
        fun("10"),
      ],),
    );
  }
  fun(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                colors: [Colors.blueAccent.shade700, Colors.purple.shade700, Colors.purple.shade200,Colors.white])),
        child: Center(
            child: Text(
              s,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
