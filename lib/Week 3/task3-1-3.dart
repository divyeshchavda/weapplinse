import 'package:flutter/material.dart';

class task313 extends StatefulWidget {
  const task313({super.key});

  @override
  State<task313> createState() => _task313State();
}

class _task313State extends State<task313> {
  late double posX;
  late double posY;
  late double imageWidth;
  late double imageHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top;

    imageWidth = screenWidth * 0.6;
    imageHeight = screenHeight * 0.5;


    posX = (screenWidth - imageWidth) / 2;
    posY = (screenHeight - imageHeight) / 2;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task 1 (Move Object Using Touch)"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: posY,
            left: posX,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  double newX = posX + details.delta.dx;
                  double newY = posY + details.delta.dy;


                  if (newX >= 0 && newX + imageWidth <= screenWidth) {
                    posX = newX;
                  }
                  if (newY >= 0 && newY + imageHeight <= screenHeight) {
                    posY = newY;
                  }
                });
              },
              child: Image.network(
                "https://img.freepik.com/free-photo/ferocious-lion-with-leaves-background_23-2150852411.jpg",
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
