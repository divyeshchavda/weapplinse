
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%208/task8-1/hero2.dart';

class hero extends StatefulWidget {
  const hero({super.key});

  @override
  State<hero> createState() => _heroState();
}

class _heroState extends State<hero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Animation"),),
    body: Column(
      children: [
        SizedBox(height: 100,),
        Text("TAP",style: GoogleFonts.poppins(fontSize: 50,fontWeight: FontWeight.w700,color: Colors.black)),
        SizedBox(height: 50,),
        Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => hero2(),));
            },
            child: Card(
              elevation: 5,
              child: ListTile(minTileHeight: 100,
                title: Hero(tag: "pc", child: Image.asset("assets/spider.jpg",height: 140,width: 80,)),
              ),
            ),
          ),
        ),
      ],
    ),
    );

  }
}
