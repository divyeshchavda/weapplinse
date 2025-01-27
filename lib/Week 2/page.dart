import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class page extends StatefulWidget {
  const page({super.key});

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page1"),
      ),
      body: Center(child: Text("Page 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
    );
  }
}
