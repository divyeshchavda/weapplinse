import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class photo extends StatefulWidget {
  List<FileSystemEntity> audioFiles = [];
  String img;

  photo({required this.audioFiles, required this.img});

  @override
  State<photo> createState() => _photoState();
}

class _photoState extends State<photo> {
  int currentIndex = 0, ind = 0;
  double s = 1.0;
  final TransformationController _transformationController =
      TransformationController();
  bool check = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.audioFiles
        .indexWhere((file) => file.path == widget.img.toString());
    print(currentIndex);
  }

  void _onSwipeRight() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _transformationController.value = Matrix4.identity();
      });
    }
  }

  void _onSwipeLeft() {
    if (currentIndex < widget.audioFiles.length - 1) {
      setState(() {
        currentIndex++;
        _transformationController.value = Matrix4.identity();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: () {
          if (check == true) {
            setState(() {
              s = 4.0;
              check = false;
            });
          } else {
            setState(() {
              s = 1.0;
              check = true;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 0) {
            _onSwipeLeft();
          } else if (details.velocity.pixelsPerSecond.dx > 0) {
            _onSwipeRight();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            widget.audioFiles[currentIndex].path.endsWith(".png")
                ? InteractiveViewer(
                    clipBehavior: Clip.none,
                    transformationController: _transformationController,
                    panEnabled: true,
                    scaleEnabled: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Image.file(
                        File(widget.audioFiles[currentIndex].path.toString())))
                : widget.audioFiles[currentIndex].path.endsWith(".jpeg")
                    ? Transform.rotate(
                        angle: 4.7,
                        child: Transform.scale(
                            scale: 0.7,
                            child: Image.file(
                              File(widget.audioFiles[currentIndex].path
                                  .toString()),
                              fit: BoxFit.fitWidth,
                            )))
                    : Transform.rotate(
                        angle: -4.7,
                        child: Transform.scale(
                            scale: 0.7,
                            child: Image.file(
                              File(widget.audioFiles[currentIndex].path
                                  .toString()),
                              fit: BoxFit.fitWidth,
                            )))
          ],
        ),
      ),
    );
  }
}
