import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'ch.dart';
import 'task5-3-3.dart'; // Profile Screen (kept your file name)

class task53 extends StatefulWidget {
  @override
  _task53State createState() => _task53State();
}

class _task53State extends State<task53> {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  bool _isLoading = false; // ✅ New state variable to track loading

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    setState(() {
      _isLoading = true; // Show loading indicator while checking session
    });

    Map<String, String>? userData = await _googleAuthService.getGoogleUserData();
    if (userData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: userData, loginMethod: "google"),
        ),
      );
    } else {
      setState(() {
        _isLoading = false; // Hide loading indicator if no session found
      });
    }
  }

  void _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true; // Show loading when user starts sign-in
    });

    GoogleSignInAccount? user = await _googleAuthService.signInWithGoogle();

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: {
            "name": user.displayName ?? "Unknown",
            "email": user.email,
            "photoUrl": user.photoUrl ?? "",
          }, loginMethod: "google"),
        ),
      );
    } else {
      setState(() {
        _isLoading = false; // Hide loading if sign-in fails
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Canceled ❌"),duration: Duration(milliseconds: 400)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Login")),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // ✅ Show loading when signing in
            : Container(
          height: 90,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: _handleGoogleSignIn,
            child: Column(
              children: [
                SizedBox(height: 5),
                Lottie.asset("assets/google.json", height: 40, width: 40),
                SizedBox(height: 5),
                Text(
                  "Sign In Google",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
