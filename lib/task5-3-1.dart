import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


import 'Week 5/task5-3.dart';
import 'Week 9/authentication/check.dart';
import 'main.dart';


class HomePage extends StatelessWidget {
  final User user;
  List b= a;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${user.displayName}!"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await GoogleSignInService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => task53()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL ?? ""),
            ),
            SizedBox(height: 10),
            Text("${user.displayName}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("${user.email}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await GoogleSignInService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => task53()),
                );
              },
              child: Container(
                  height: MediaQuery.of(context).size.height*0.072,
                  width: MediaQuery.of(context).size.height*0.42,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text("LOG OUT",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),))),
            ),
          ],
        ),
      ),
    );
  }
}


