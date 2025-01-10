import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task1 extends StatefulWidget {
  const task1({super.key});

  @override
  State<task1> createState() => _task1State();
}

class _task1State extends State<task1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK 1"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("____What Is Flutter??____",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("   Flutter is an open-source framework from Google that allows developers to build applications for multiple platforms using a single codebase . Platforms Flutter supports development for iOS, Android, the web, Windows, MacOS, and Linux",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.07,fontStyle: FontStyle.italic),),
            )
          ],
        ),
      ),
    );
  }
}
