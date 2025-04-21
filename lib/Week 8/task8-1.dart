import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pocketcoach/Week%206/task6-3-1/banner.dart';
import 'package:pocketcoach/Week%206/task6-3-1/intertiatial.dart';
import 'package:pocketcoach/Week%206/task6-3-1/native.dart';
import 'package:pocketcoach/Week%206/task6-3-1/native2.dart';
import 'package:pocketcoach/Week%206/task6-3-1/rewarded.dart';
import 'package:pocketcoach/Week%206/task6-3-1/rewarded2.dart';
import 'package:pocketcoach/Week%206/task6-3-1/video.dart';
import 'package:pocketcoach/Week%208/task8-1/calig.dart';
import 'package:pocketcoach/Week%208/task8-1/canim.dart';
import 'package:pocketcoach/Week%208/task8-1/hero.dart';
import 'package:pocketcoach/Week%208/task8-1/cicon.dart';
import 'package:pocketcoach/Week%208/task8-1/cop.dart';

import '../Week 5/video.dart';


class task81 extends StatefulWidget {
  const task81({super.key});

  @override
  State<task81> createState() => _task81State();
}

class _task81State extends State<task81> {
  BannerAd? _bannerAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations"),
      ),
      body:  ListView(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => canim(),));
              },
              child:
              Text("Animated Container",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  cop(),));
              },
              child:
              Text("Animated Opacity",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  calig(),));
              },
              child:
              Text("Animated Alignment",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  cicon(),));
              },
              child:
              Text("Animated Icon",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  hero(),));
              },
              child:
              Text("Hero Animation",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
