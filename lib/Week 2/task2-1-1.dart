import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task211 extends StatefulWidget {
  final String rno,name,city,pass;
  const task211({required this.rno,required this.name,required this.city,required this.pass});

  @override
  State<task211> createState() => _task211State();
}

class _task211State extends State<task211> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 2-1-1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Roll No = ${widget.rno}",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name = ${widget.name}",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("City = ${widget.city}",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("PassWord = ${widget.pass}",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("BACK",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );;
  }
}
