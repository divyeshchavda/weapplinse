import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class task3 extends StatefulWidget {
  const task3({super.key});

  @override
  State<task3> createState() => _task3State();
}

class _task3State extends State<task3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Basic Of Language??",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Uri uri = Uri.parse(
                    "https://drive.google.com/file/d/1rD0bBBsnbDW6QOAkv-hMG_EHWaOA3AFW/view?usp=sharing");
                launchUrl(uri);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Press For File",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
