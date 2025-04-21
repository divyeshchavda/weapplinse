import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cop extends StatefulWidget {
  const cop({super.key});

  @override
  State<cop> createState() => _copState();
}

class _copState extends State<cop> {
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Opacity"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: AnimatedOpacity(curve: Curves. easeIn,
                duration:  Duration(seconds: 1),
                opacity: check==false?1.0:0.0,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(35)
                  ),
                ),
              )),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                if(check==false){
                  setState(() {
                    check=true;
                  });
                }
                else{
                  setState(() {
                    check=false;
                  });
                }
              },
              child:
              Text("Tap To Animate",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
