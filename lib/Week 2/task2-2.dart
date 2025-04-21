import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%202/task2-2-1.dart';
import 'package:pocketcoach/Week%202/task2-2-2.dart';
import 'package:pocketcoach/Week%202/task2-2-3.dart';
import 'package:pocketcoach/Week%202/task2-2-4-2.dart';
import 'package:pocketcoach/Week%202/task2-2-4.dart';


class task22 extends StatefulWidget {
  const task22({super.key});

  @override
  State<task22> createState() => _task22State();
}

class _task22State extends State<task22> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task221(),));
                },
                child: Text("Basic Widgets",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task222(),));
                },
                child: Text("Layout Widgets",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task223(),));
                },
                child: Text("Interactive Widgets",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task224(),));
                },
                child: Text("List Widget",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task2242(),));
                },
                child: Text("Grid Widget",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }
}
