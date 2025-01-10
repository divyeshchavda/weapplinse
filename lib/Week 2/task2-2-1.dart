import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task221 extends StatefulWidget {
  const task221({super.key});

  @override
  State<task221> createState() => _task221State();
}

class _task221State extends State<task221> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2 (Basic Widgets)"),
      ),
      body: ListView(
        children: [
          Text("1. Text",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          SizedBox(height: 30,),
          Text("2. Image",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          Image.asset("assets/1.jpg"),
          Text("3. Icon",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          Icon(Icons.ac_unit,size: 60,color: Colors.blue,)
        ],
      ),
    );
  }
}
