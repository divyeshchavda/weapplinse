import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%207/pay2.dart';
import 'package:pocketcoach/Week%208/task8-1.dart';
import 'package:pocketcoach/Week%208/task8-2.dart';
import 'package:pocketcoach/Week%208/task8-3.dart';
import 'package:pocketcoach/Week%208/task8-4.dart';
import 'package:pocketcoach/Week%208/task8-5.dart';
import 'package:pocketcoach/Week%209/branch.dart';
import 'package:pocketcoach/Week%209/crash.dart';

import 'package:pocketcoach/Week%209/firestore/fsdatabase.dart';
import 'package:pocketcoach/Week%209/realtime/rd.dart';
import 'package:pocketcoach/Week%209/t.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../week.dart';
import 'authentication/HOME.dart';
import 'authentication/authentication.dart';
import 'fnotification.dart';
import 'notification.dart';
class week9 extends StatefulWidget {
  const week9({super.key});

  @override
  State<week9> createState() => _week9State();
}

class _week9State extends State<week9> {
  List<CameraDescription> cameras=[];
  var email;
  var method;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  void get() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email=await prefs.getString("email");
    method=await prefs.getString("method");
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => week()),(route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WEEK 9 & 10"),
        ),
        body:ListView(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  var email=await prefs.getString('email');
                  email==null?Navigator.push(context, MaterialPageRoute(builder: (context) => authentication(),)):Navigator.push(context, MaterialPageRoute(builder: (context) => HOME(email: email, login: method,),));
                },
                child:
                Text("Authentication",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeListScreen(),));
                },
                child:
                Text("Realtime Database",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => fsdatabase(),));
                },
                child:
                Text("Firestore Database",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => analytic(),));
                },
                child:
                Text("Analytics",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => crash(),));
                },
                child:
                Text("Crashlytics",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => notification(),));
                },
                child:
                Text("Local Notification",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => fnotification(),));
            //     },
            //     child:
            //     Text("Push Notification",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => branch(),));
                },
                child:
                Text("Dynamic Links",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
