import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task222 extends StatefulWidget {
  const task222({super.key});

  @override
  State<task222> createState() => _task222State();
}

class _task222State extends State<task222> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2 (Layout Widgets)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("1. Row",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          ),
          Row(
            children: [
              Text("Example 01,",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),),
              Text("Example 02,",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),),
              Text("Example 03,",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("2. Column",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          ),
          Column(
            children: [
              Text("Example 01,",style: TextStyle(fontSize: 25),),
              Text("Example 02,",style: TextStyle(fontSize: 25),),
              Text("Example 03,",style: TextStyle(fontSize: 25),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("3. Container",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black),
              ),
              child: Center(child: Text("   Container is Also Used To Organize Widget in it Like I use Text in it",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
