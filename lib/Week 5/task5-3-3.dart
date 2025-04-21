import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ch.dart';
import 'ch2.dart';
import 'task5-3.dart'; // Google Login Screen
import 'task5-3-2.dart'; // Facebook Login Screen

class task533 extends StatefulWidget {
  final Map<String, String> userData;
  final String loginMethod; // "google" or "facebook"

  task533({required this.userData, required this.loginMethod});

  @override
  State<task533> createState() => _task533State();
}

class _task533State extends State<task533> {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final FacebookAuthService _facebookAuthService = FacebookAuthService();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userData);
  }
  void _handleLogout() async {
    if (widget.loginMethod == "google") {
      await _googleAuthService.signOutGoogle();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => task53())); // Google login screen
    } else if (widget.loginMethod == "facebook") {
      await _facebookAuthService.signOutFacebook();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => task532())); // Facebook login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 100, backgroundImage: NetworkImage(widget.userData["photoUrl"]!)),
                  SizedBox(height: 10,),
                  Text(widget.userData["name"]!,style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),),
                  SizedBox(height: 10,),
                  Text(widget.userData["email"]!,style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),),
                  SizedBox(height: 20,),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                    onPressed: _handleLogout,
                    child: Text("Logout",style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
