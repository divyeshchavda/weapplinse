import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task233 extends StatefulWidget {
  const task233({super.key});

  @override
  State<task233> createState() => _task233State();
}

class _task233State extends State<task233> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Advance Layout Widget)"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("It's Contain Many Widgets Like Expanded,Flexible,Gridview,Wrap etc. Forward We Are Discuss that Gridview so We Display Other Widget ",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("1. Expanded",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Row(
              children: [
                Expanded(flex:1,child: Container(width: 100,color:Colors.blue,child: Text("Hello!!!",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white)))),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(width: 100,color:Colors.blue,child: Text("Hello!!! Without Expanded",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("2. Flexible",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Row(
              children: [
                Flexible(child: Container(width: 200,color:Colors.blue,child: Text("Hello!!! Without Expanded",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white)))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("3. Wrap",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Wrap(
              children: [
                Container(width: 100,height: 100,color: Colors.blue,),
                Container(width: 100,height: 100,color: Colors.black,),
                Container(width: 100,height: 100,color: Colors.yellow,),
                Container(width: 100,height: 100,color: Colors.greenAccent,),
                Container(width: 100,height: 100,color: Colors.blue,),
                Container(width: 100,height: 100,color: Colors.black,),
                Container(width: 100,height: 100,color: Colors.yellow,),
                Container(width: 100,height: 100,color: Colors.greenAccent,),
                Container(width: 100,height: 100,color: Colors.blue,),
                Container(width: 100,height: 100,color: Colors.black,),
                Container(width: 100,height: 100,color: Colors.yellow,),
                Container(width: 100,height: 100,color: Colors.greenAccent,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
