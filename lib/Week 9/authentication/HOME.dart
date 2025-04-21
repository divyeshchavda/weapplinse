import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%209/authentication/authentication.dart';
import 'package:pocketcoach/Week%209/week9.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'check.dart';

class HOME extends StatefulWidget {
  String? email;
  String? login;

  HOME({required this.email,required this.login});

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  var email="";
  @override
  void initState() {
    get();
    super.initState();
    print(widget.email);
    print(widget.login);
  }

  void get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     email=(await prefs.getString('email'))!;
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var email=await prefs.getString('email');
        if(email!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => week9(),));
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("HOME"),
        ),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),onPressed: () async {
              if(widget.login=="email"){
                    signOut();
                  }
              else if(widget.login=="google"){
                GoogleSignInService.signOut();
              }
              else{
                FacebookSignInService.signOut2();
              }
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('email');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => authentication(),));
            }, child: Text("LOG OUT",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white))),
            Text("WELCOME TO HOME PAGE",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black)),
            Text(widget.email!,style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black)),
          ],
        )),
      ),
    );
  }
}
