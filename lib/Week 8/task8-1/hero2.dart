import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class hero2 extends StatefulWidget {
  const hero2({super.key});

  @override
  State<hero2> createState() => _hero2State();
}

class _hero2State extends State<hero2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation 2"),),
      body: Column(
        children: [
          Hero(tag: "pc", child: Image.asset("assets/spider.jpg",height: 200,width: 370,)),
          SizedBox(height: 10,),
          Text("Spider-Man",style: GoogleFonts.almendra(fontSize: 50,fontWeight: FontWeight.w700,color: Colors.black))
        ],
      ),
    );
  }
}
