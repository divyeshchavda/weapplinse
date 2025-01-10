import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%202/helper.dart';
import 'package:weapplinse/Week%202/helper2.dart';
import 'package:weapplinse/week.dart';

class task24 extends StatefulWidget {
  const task24({super.key});

  @override
  State<task24> createState() => _task24State();
}

class _task24State extends State<task24> {
  var a=helper();
  var b = week();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 4(Custom Widget Properties)"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: a.customtext("Style 1"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: a.customtext2("Style 2"),
          ),
          btn(btnname: "Custom Button",color: Colors.blue,Callback: (){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: a.customtext2("Custom Widget")));
          },),

        ],
      ),
    );
  }
}
