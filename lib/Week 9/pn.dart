import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class pn extends StatelessWidget {
  static const String route = '/pn';

  const pn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PN Screen")),
      body: Center(
        child: Text(
          "You navigated from notification!",
          style: GoogleFonts.poppins(
              fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
    );
  }
}
