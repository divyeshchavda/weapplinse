import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page3"),
      ),
      body: Center(child: Text("Page 3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
    );
  }
}
