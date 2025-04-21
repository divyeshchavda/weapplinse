import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class calig extends StatefulWidget {
  const calig({super.key});

  @override
  State<calig> createState() => _caligState();
}

class _caligState extends State<calig> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Alignment"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
            onTap: () {
              if (check == false) {
                setState(() {
                  check = true;
                });
              } else {
                setState(() {
                  check = false;
                });
              }
            },
            child: AnimatedAlign(
              curve: Curves.bounceOut,
              duration: Duration(seconds: 1),
              alignment:
                  check == false ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(35)),
                child: Center(
                    child: Text(
                  "TAP ME",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
              ),
            ),
          )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
