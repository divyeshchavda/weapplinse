import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task234 extends StatefulWidget {
  const task234({super.key});

  @override
  State<task234> createState() => _task234State();
}

class _task234State extends State<task234> {
  final _key = GlobalKey<FormState>();
  var b="";
  var a=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Input Fields)"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "It's Contain Many Widgets Like TextField,TextFormfield. Forward We Are Discuss that TextField so We Display Other Widget ",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("TextFormfield",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        backgroundColor: Colors.black,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: a,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Name Its Required";
                      }
                      return null;
                    },
                      decoration: InputDecoration(
                      filled: true
                      ,fillColor: Colors.white,labelText: 'DATA',
                        hintText: 'Enter your DATA',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(Icons.onetwothree),
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      b=a.text.toString();
                    });
                    if(_key.currentState?.validate()??false){
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
                      a.clear();
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
