import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class task312 extends StatefulWidget {
  const task312({super.key});

  @override
  State<task312> createState() => _task312State();
}

class _task312State extends State<task312> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task1(Swipe left/right/up/down)"),
      ),
      body:Column(
        children: [
          Container(child: CarouselSlider(items: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_2.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_3.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_4.png"),
            )
          ], options: CarouselOptions(scrollDirection: Axis.horizontal),),),
          SizedBox(height: 50,),
          Container(child: CarouselSlider(items: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_2.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_3.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/img_4.png"),
            )
          ], options: CarouselOptions(scrollDirection: Axis.vertical),),),
        ],
      ),
    );
  }
}
