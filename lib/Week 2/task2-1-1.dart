import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task211 extends StatefulWidget {
  final String rno, name, city, pass;
  final File? file;
  task211({required this.rno, required this.name, required this.city, required this.pass, required this.file});

  @override
  State<task211> createState() => _task211State();
}

class _task211State extends State<task211> {
  File? f;

  @override
  void initState() {
    super.initState();
    f = File(widget.file!.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 2-1-1"),
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture Section
                  GestureDetector(
                    onTap: () {
                      // Add functionality for changing profile picture if needed
                    },
                    child: CircleAvatar(
                      backgroundImage: FileImage(widget.file!),
                      radius: 80,
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Display User Information with Styling
                  infoCard("Roll No", widget.rno),
                  SizedBox(height: 10),
                  infoCard("Name", widget.name),
                  SizedBox(height: 10),
                  infoCard("City", widget.city),
                  SizedBox(height: 10),
                  infoCard("Password", widget.pass),

                  SizedBox(height: 40),

                  // Back Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("BACK", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget to create information card
  Widget infoCard(String label, String value) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
