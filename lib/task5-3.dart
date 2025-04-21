import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketcoach/task5-3-1.dart';

import 'Week 9/authentication/check.dart';




class task53 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Social Media Sign-In")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () async {
                  User? user = await GoogleSignInService.signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user: user)));
                  } else {
                    print("❌ Google Sign-In Failed");
                  }
                },
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Lottie.asset("assets/google.json",height: 30,width: 30,),
                    SizedBox(height: 5,),
                    Text("Sign in with Google",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () async {
                  User? user = await FacebookSignInService.signInWithFacebook();
                  if (user != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user: user)));
                  } else {
                    print("❌ Facebook Sign-In Failed");
                  }
                },
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Lottie.asset("assets/facebook.json",height: 30,width: 30,reverse: true),
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
