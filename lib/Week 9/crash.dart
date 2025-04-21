import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase_options.dart';


class crash extends StatefulWidget {
  const crash({super.key});

  @override
  State<crash> createState() => _crashState();
}

class _crashState extends State<crash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crashlytics Button Example'),
      ),
      body: Center(
        child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
          onPressed: () {
            throw Exception('This is a forced crash!');
          },
          child: Text('Crash the app',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
        ),
      ),
    );
  }
}