import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task231 extends StatefulWidget {
  const task231({super.key});

  @override
  State<task231> createState() => _task231State();
}

class _task231State extends State<task231> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Single Child Layout Widgets)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("It's Contain Many Widgets Like Container,Center,Padding,Align etc. Forward We Are Discuss that Container so We Display Other Widget ",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("1. Center",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Hello!!!",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("2. Padding",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Container(color:Colors.blue,child: Text("It's Add Space Around Its Child",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white))),
          ),
          Container(color:Colors.blue,child: Text("It's Without Padding",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("3. Align",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.bottomRight,child: Text("Use Of Align",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.black))),
          ),
        ],
      ),
    );
  }
}
