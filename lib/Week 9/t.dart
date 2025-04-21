import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_fonts/google_fonts.dart';

class analytic extends StatefulWidget {
  @override
  _analyticState createState() => _analyticState();
}

class _analyticState extends State<analytic> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Analytics Example'),
      ),
      body: Center(
        child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
          onPressed: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Button Tapped"),
                backgroundColor: Colors.green,duration: Duration(milliseconds: 400),
              ),
            );
            await analytics.logEvent(
              name: 'button_pressed',
              parameters: <String, String>{
                'button_name': 'Test Button',
              },
            );
            print('Event logged: button_pressed');

          },
          child: Text('Press me',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
        )
      ),
    );
  }
}
