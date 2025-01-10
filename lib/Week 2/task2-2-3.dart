import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task223 extends StatefulWidget {
  const task223({super.key});

  @override
  State<task223> createState() => _task223State();
}

class _task223State extends State<task223> {
  void tap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Single Tap",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white)),
        duration: Duration(seconds: 2),
        shape: Border.all(color: Colors.black),
      ),
    );
  }

  void doubletap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Double Tap",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white)),
        duration: Duration(seconds: 2),
        shape: Border.all(color: Colors.black),
      ),
    );
  }

  void longpress() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Long press",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white)),
        duration: Duration(seconds: 2),
        shape: Border.all(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var e=TextEditingController();
    var b = "";
    return Scaffold(
        appBar: AppBar(
          title: Text("Task2 (Interactive Widgets)"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("1. Gesture Detactor",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: tap,
                onLongPress: longpress,
                onDoubleTap: doubletap,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                      child: Text("Press And Check By Yourself",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("2. Buttons",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Elevated Button Pressed",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white)),
                          duration: Duration(seconds: 2),
                          shape: Border.all(color: Colors.black),
                        ));
                      },
                      child: Text(
                        "Elevated Button",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Outlined Button Pressed",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  }, child: Text(
                    "Outlined Button",
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Text Button Pressed",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  }, child: Text(
                    "Text Button",
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Icon Button Pressed",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  }, icon: Icon(Icons.ac_unit,size: 50,color: Colors.blue,)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("3. TextField",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.black,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: e,
                  decoration: InputDecoration(
                    labelText: 'DATA',
                    hintText: 'Enter your DATA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.onetwothree),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if(e.text.isNotEmpty){
                      setState(() {
                        b=e.text.toString();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(b,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        duration: Duration(seconds: 2),
                        shape: Border.all(color: Colors.black),
                      ));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("PLZ ENTER DATA ITS REQUIRED",
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        duration: Duration(seconds: 2),
                        shape: Border.all(color: Colors.black),
                      ));
                    }
                  },
                  child: Text(
                    "Submit Data",
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ));
  }
}
