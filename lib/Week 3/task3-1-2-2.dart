import 'package:flutter/material.dart';

class task3122 extends StatefulWidget {
  @override
  _task3122State createState() => _task3122State();
}

class _task3122State extends State<task3122> {
  final List<String> images = [
    'assets/img_2.png',
    'assets/img_3.png',
    'assets/img_4.png',
  ];

  int currentIndex = 0;

  void _onSwipeUp() {
    if (currentIndex < images.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _onSwipeDown() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void _onSwipeRight() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void _onSwipeLeft() {
    if (currentIndex < images.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipe Photos in All Directions"),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 0) {

            _onSwipeLeft();
          } else if (details.velocity.pixelsPerSecond.dx > 0) {

            _onSwipeRight();
          }
        },
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy < 0) {

            _onSwipeUp();
          } else if (details.velocity.pixelsPerSecond.dy > 0) {

            _onSwipeDown();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              images[currentIndex],
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}