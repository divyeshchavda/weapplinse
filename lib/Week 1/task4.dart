import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class task4 extends StatefulWidget {
  const task4({super.key});

  @override
  State<task4> createState() => _task4State();
}

class _task4State extends State<task4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Dart Programming??",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
            ),
            ElevatedButton(onPressed: () {
              Uri uri=Uri.parse("https://drive.google.com/file/d/1EBGWBc3PfWQADVpOFLayUNGf6zvYnwVa/view?usp=sharing");
              launchUrl(uri);
            }, child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Press For File",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
            )),
          ],
        ),
      ),
    );
  }
}
