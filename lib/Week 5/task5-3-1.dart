import 'package:flutter/material.dart';
import 'ch.dart';
import 'ch2.dart';
import 'task5-3.dart';  // Google Login Screen
import 'task5-3-2.dart'; // Facebook Login Screen
import 'task5-3-3.dart'; // Profile Screen

class task531 extends StatefulWidget {
  @override
  _task531State createState() => _task531State();
}

class _task531State extends State<task531> {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final FacebookAuthService _facebookAuthService = FacebookAuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    Map<String, String>? googleUser = await _googleAuthService.getGoogleUserData();
    if (googleUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: googleUser, loginMethod: "google"),
        ),
      );
      return;
    }

    Map<String, String>? facebookUser = await _facebookAuthService.getFacebookUserData();
    if (facebookUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => task533(userData: facebookUser, loginMethod: "facebook"),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
