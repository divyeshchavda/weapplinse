import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:weapplinse/Week%203/api2.dart';
import 'package:weapplinse/Week%203/task3-3-4.dart';
import 'package:weapplinse/Week%203/test.dart';

class task331 extends StatefulWidget {
  const task331({super.key});

  @override
  State<task331> createState() => _task331State();
}

class _task331State extends State<task331> {
  final k = GlobalKey<FormState>();
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  var error="";
  final fetch = api();
  var rno;
  var name = "", email = "", pic = "";
  File? file;
  Future<void> select() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
    else {
      // User canceled the picker
      setState(() {
        error = "No file selected.";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2(Insert data)"),
      ),
      body: Form(
        key: k,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return "Plz Enter Name Its Required";
                    }
                    return null;
                  },
                  controller: a,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return "Plz Enter Email Its Required";
                    }
                    else if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(a)){
                      return "Plz Valid Email Its Required";
                    }
                    return null;
                  },
                  controller: b,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  select();
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.file_present_sharp,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("PickFile",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                )),
            Text(error,style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: ()  async {
                    if (k.currentState?.validate() ?? false ) {
                      if(file==null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter File Also')),
                        );
                      }
                      else {
                        setState(() {
                          name = a.text.toString();
                          email = b.text.toString();
                          pic = file.toString();
                          print("$name+$email+$pic");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("INSERTED SUCCESSFULLY",
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.05,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),
                            duration: Duration(seconds: 2),
                            shape: Border.all(color: Colors.black),
                          ));
                        });
                        api.add(name: name, email: email, pic: file!);
                        print("Success");
                        a.clear();
                        b.clear();
                      }
                      }
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserListScreen(),));
            }, child: Text("SHOW", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
