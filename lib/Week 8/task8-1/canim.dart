import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class canim extends StatefulWidget {
  const canim({super.key});

  @override
  State<canim> createState() => _canimState();
}

class _canimState extends State<canim> {
  double height = 150, width = 150;
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Container"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
                onTap: (){
                  if(check==true){
                    setState(() {
                      height=300;
                      width=300;
                      check=false;
                    });
                  }
                  else{
                    setState(() {
                      height=150;
                      width=150;
                      check=true;
                    });
                  }
                },
                child: AnimatedContainer(curve: Curves.bounceOut,
                            duration: Duration(seconds: 1),
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                  color: check==true?Colors.black:Colors.blue,
                borderRadius: BorderRadius.circular(check==true?0:35)
                            ),
                          child:Center(child: Text("Tap To Animate",style: GoogleFonts.poppins(fontSize: check==true?15:30,fontWeight: FontWeight.w700,color: Colors.white),)),
                    ),
              )),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
