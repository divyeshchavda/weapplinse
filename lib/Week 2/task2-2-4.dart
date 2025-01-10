import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task224 extends StatefulWidget {
  const task224({super.key});

  @override
  State<task224> createState() => _task224State();
}

class _task224State extends State<task224> {
  List Item = ["Divyesh","Manishbhai","Chavda","I","Make","Application","Demo","i","Am","Work","In","Weapplinse","I","Studieying","In","Sutex","College"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2 (List Widget)"),
      ),
      body: Center(
        child: ListView.builder(itemCount: 17,itemBuilder: (context, index) {
          return ListTile(title: Text(Item[index],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white)),);
        },),
      ),
    );
  }
}
