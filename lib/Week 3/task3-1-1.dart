import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task311 extends StatefulWidget {
  const task311({super.key});

  @override
  State<task311> createState() => _task311State();
}

class _task311State extends State<task311> {
  var s = 1.0;
  var ps = 1.0,min=1.0,max=9.0;
  bool check=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task1(Pinch To Zoom-In/Out)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GestureDetector(
              onDoubleTap: (){
                if(check==true){
                  setState(() {
                    s=4.0;
                    check=false;
                  });
                }
                else{
                  setState(() {
                    s=1.0;
                    check=true;
                  });
                }
              },
              onScaleStart: (ScaleStartDetails details){
            ps=s;
          },onScaleUpdate: (ScaleUpdateDetails details){
            setState(() {
              s=(ps*details.scale).clamp(min, max);
            });
          },onScaleEnd: (ScaleEndDetails details){
            ps=1.0;
          },
              child: Transform.scale(scale: s,child: Image.asset("assets/img_1.png"))),
        ),
      ),
    );
  }
}
