import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-1-1.dart';
import 'package:weapplinse/Week%203/test.dart';
import 'package:weapplinse/Week%203/task3-1-2.dart';
import 'package:weapplinse/Week%203/task3-1-3.dart';

class task31 extends StatefulWidget {
  const task31({super.key});

  @override
  State<task31> createState() => _task31State();
}

class _task31State extends State<task31> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task1"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task311(),));
                },
                child: Text("Pinch To Zoom-In/Out",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task312(),));
                },
                child: Text("Swipe left/right/up/down",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task313(),));
                },
                child: Text("Move Object Using Touch",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      )
    );
  }
}
