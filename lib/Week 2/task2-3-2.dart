import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task232 extends StatefulWidget {
  const task232({super.key});

  @override
  State<task232> createState() => _task232State();
}

class _task232State extends State<task232> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Multi-Child Layout Widget)"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("It's Contain Many Widgets Like Row,Column,Stack,Listview etc. Forward We Are Discuss that Row,Column and Listview so We Display Other Widget ",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("1. Stack",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Stack(
            children: [
              Container(width: 100,height: 200,color: Colors.blue,),
              Container(width: 200,height: 100,color: Colors.black,),
              Container(width: 70,height: 150,color: Colors.yellow,),
              Container(width: 150,height: 70,color: Colors.greenAccent,),
            ],
          )
        ],
      ),
    );
  }
}
