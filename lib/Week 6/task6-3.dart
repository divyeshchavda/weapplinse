import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketcoach/Week%206/task6-3-1.dart';
import 'package:pocketcoach/Week%206/task6-3-2.dart';


class task63 extends StatefulWidget {
  const task63({super.key});

  @override
  State<task63> createState() => _task63State();
}

class _task63State extends State<task63> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AD-MOB & Facebook ADS"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task631(),));
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/ads.json", height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "AD-MOB",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => task632(),));
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/facebook.json", height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "Facebook ADS",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
