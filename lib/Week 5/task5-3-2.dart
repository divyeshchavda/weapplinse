import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'ch2.dart';
import 'task5-3-3.dart'; // Profile Screen (kept your file name)

class task532 extends StatefulWidget {
  @override
  _task532State createState() => _task532State();
}

class _task532State extends State<task532> {
  final FacebookAuthService _facebookAuthService = FacebookAuthService();
 bool check=true;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    Map<String, String>? userData = await _facebookAuthService.getFacebookUserData();
    if (userData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: userData, loginMethod: "facebook"),
        ),
      );
    }

  }

  void _handleFacebookSignIn() async {
    setState(() {
      check=false;
    });
    Map<String, dynamic>? userData = await _facebookAuthService.signInWithFacebook();
    if (userData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: {
            "name": userData["name"] ?? "Unknown",
            "email": userData["email"] ?? "No Email",
            "photoUrl": userData["picture"]["data"]["url"] ?? "",
          }, loginMethod: "facebook"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Facebook Sign-In Canceled ❌"),duration: Duration(milliseconds: 400),),
      );
    }setState(() {
      check=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Facebook Login")),
      body: Center(
        child: Container(
          height: 90,
          width: 280,
          child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
            onPressed: () {
             check==true?_handleFacebookSignIn():();
            },
            child: Column(
              children: [
                SizedBox(height: 10,),
                Lottie.asset("assets/facebook.json",height: 40,width: 40),
                SizedBox(height: 10,),
                Text("Sign in with Facebook",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
