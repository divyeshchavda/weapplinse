import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task224 extends StatefulWidget {
  const task224({super.key});

  @override
  State<task224> createState() => _task224State();
}

class _task224State extends State<task224> {
  List Item = ['1 Divyesh','2 Dev','3 Priyanshu','4 Rutvik','5 Harshil','6 Roshan','7 Yatin','8 Sujal','9 Meet','10 Heet'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2 (List Widget)"),
      ),
      body: Center(
        child: ListView.builder(itemCount: Item.length,itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20))),child: ListTile(title: Center(child: Text('${Item[index]}',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black))),)),
          );
        },),
      ),
    );
  }
}
