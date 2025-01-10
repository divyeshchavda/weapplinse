import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%201/week1.dart';
import 'package:weapplinse/Week%202/week2.dart';
import 'package:weapplinse/week.dart';

class task2310 extends StatefulWidget {
  const task2310({super.key});

  @override
  State<task2310> createState() => _task2310State();
}

class _task2310State extends State<task2310> {
  PageController pageController=PageController();
  void change2(int index){
    setState(() {
      inde=index;
    });
  }
  void change(int i ){
    setState(() {
      pageController.jumpToPage(i);
    });
  }
  int inde=0;
  List<Widget> body=[week(),week1(),week2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Bottom Navigation Bar)"),
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: inde,onTap:change,items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_one),label: "Week 1"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_two),label: "Week 2"),
      ]),
      body: PageView(
        controller: pageController,
        children:body,
        onPageChanged: change2,
      ),
    );
  }
}
