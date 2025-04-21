import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%202/page.dart';
import 'package:pocketcoach/Week%202/page2.dart';
import 'package:popover/popover.dart';

import '../Week 2/page3.dart';

class task85 extends StatefulWidget {
  const task85({super.key});

  @override
  State<task85> createState() => _task85State();
}

class _task85State extends State<task85> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Popover Menu Example")),
      body: Align(
        alignment: Alignment.center,
        child: Builder(
          builder: (context) => ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black),
            onPressed: () {
              showPopover(
                context: context,
                barrierDismissible: false,
                bodyBuilder: (context) {
                  return Column(
                    children: [
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => page(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                                color: Colors.blue[50],
                                height: 50,
                                width: 200,
                                child: Center(
                                    child: Text("PAGE 1",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => page2(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                                color: Colors.blue.shade100,
                                height: 50,
                                width: 200,
                                child: Center(
                                    child: Text("PAGE 2",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => page3(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Container(
                                color: Colors.blue.shade300,
                                height: 50,
                                width: 200,
                                child: Center(
                                    child: Text("PAGE 3",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            child: Center(
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red)))),
                      ),
                    ],
                  );
                },

                backgroundColor: Colors.white,
                width: 200,
                height: 230,
                arrowHeight: 10,
                arrowWidth: 20,
                barrierColor: Colors.transparent, // Prevents overlay blocking
              );
            },
            child: Text(
              "Show Popover Menu",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
