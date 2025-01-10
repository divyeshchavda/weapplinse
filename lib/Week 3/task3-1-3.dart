import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task313 extends StatefulWidget {
  const task313({super.key});

  @override
  State<task313> createState() => _task313State();
}

class _task313State extends State<task313> {
  double posx = 100;
  double posy = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task1(Move Object Using Touch)"),
      ),
      body: Stack(children: [
        Positioned(
          top: posy,
          left: posx,
          child: GestureDetector(
            onPanUpdate: (details){
              setState(() {
                posy+=details.delta.dy;
                posx+=details.delta.dx;
              });
            },
              child: Image.network(
                  "https://img.freepik.com/free-photo/ferocious-lion-with-leaves-background_23-2150852411.jpg",height: 500,width: 250,)),
        ),
      ]),
    );
  }
}
