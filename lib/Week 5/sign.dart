import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%205/task5-3-2.dart';

import 'package:pocketcoach/Week%205/task5-3.dart';


class sign extends StatefulWidget {
  const sign({super.key});

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Social Media Sign-In")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  task53(),));
                },
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Text("Sign in with Google",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task532(),));
                },
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Sign in with Facebook",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
