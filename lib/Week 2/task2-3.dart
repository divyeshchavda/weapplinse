import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%202/task2-3-10.dart';
import 'package:weapplinse/Week%202/task2-3-6.dart';
import 'package:weapplinse/Week%202/task2-3-1.dart';
import 'package:weapplinse/Week%202/task2-3-2.dart';
import 'package:weapplinse/Week%202/task2-3-3.dart';
import 'package:weapplinse/Week%202/task2-3-4.dart';
import 'package:weapplinse/Week%202/task2-3-5.dart';
import 'package:weapplinse/Week%202/task2-3-7.dart';
import 'package:weapplinse/Week%202/task2-3-8.dart';
import 'package:weapplinse/Week%202/task2-3-9.dart';

class task23 extends StatefulWidget {
  const task23({super.key});

  @override
  State<task23> createState() => _task23State();
}

class _task23State extends State<task23> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task3"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("Layout Widgets",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        backgroundColor: Colors.black,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task231(),
                        ));
                  },
                  child: Text("Single Child Layout Widgets",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task232(),
                        ));
                  },
                  child: Text("Multi-Child Layout Widgets",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task233(),
                        ));
                  },
                  child: Text("Advanced Layout Widgets",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("Control Widgets",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        backgroundColor: Colors.black,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("We Complete All Button so We Dont Include That",style: TextStyle(fontSize: MediaQuery.of(context).size.width* 0.06,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task234(),
                        ));
                  },
                  child: Text("Input Fields",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task235(),
                        ));
                  },
                  child: Text("Selection Controls",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task236(),
                        ));
                  },
                  child: Text("Slider Controls",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task237(),
                        ));
                  },
                  child: Text("Picker Controls",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task238(),
                        ));
                  },
                  child: Text("Tab Menu",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task239(),
                        ));
                  },
                  child: Text("Navigation Drawer",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => task2310(),
                        ));
                  },
                  child: Text("Bottom Navigation Bar",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
          ],
        ));
  }
}
