import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%202/task2-1-1.dart';
import 'package:file_picker/file_picker.dart';

class task21 extends StatefulWidget {
  const task21({super.key});

  @override
  State<task21> createState() => _task21State();
}

class _task21State extends State<task21> {
  final k = GlobalKey<FormState>();
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  var error;
  var rno;
  File? f;
  File? file;
  bool show = true;
  var name = "", city = "", rnos = "", pass = "";

  Future<void> select() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        error = "File selected.";
      });
    } else {
      // User canceled the picker
      setState(() {
        error = "No file selected.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Task1(Data Pass Between 2 page)"),
      ),
      body: Form(
        key: k,
        child: ListView(
          children: [
            Center(
              child: Container(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: file != null
                              ? Image.file(
                                  file!,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(
                                  "NO FILE SELECTED",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ))),
                    ),
                    Positioned(
                      top: 90,
                      left: 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: CircleBorder()),
                          onPressed: () {
                            select();
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: a,
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return "Plz Enter Roll no Its Required";
                    }
                    return null;
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Roll No',
                    hintText: 'Enter your Roll No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.onetwothree),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return "Plz Enter Name Its Required";
                    }
                    return null;
                  },
                  controller: b,
                  maxLength: 20,
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
                  controller: c,
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return "Plz Enter Its Required";
                    }
                    return null;
                  },
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: 'City',
                    hintText: 'Enter your City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.location_city),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: d,
                  validator: (a) {
                    if (a == null || a.isEmpty) {
                      return 'Password is required';
                    }
                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                        .hasMatch(a!)) {
                      return """Password is Must Contain 8 character,uppercase,
lowercase,digit and special character""";
                    }
                    return null;
                  },
                  maxLength: 15,
                  obscureText: show,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (show == true) {
                            setState(() {
                              show = false;
                            });
                          } else {
                            setState(() {
                              show = true;
                            });
                          }
                        },
                        icon: show == true
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined)),
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.password),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (k.currentState?.validate() ?? false) {
                      if (file != null) {
                        setState(() {
                          f = file!;
                          rnos = a.text.toString();
                          name = b.text.toString();
                          city = c.text.toString();
                          pass = d.text.toString();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => task211(
                                  rno: rnos,
                                  name: name,
                                  city: city,
                                  pass: pass,
                                  file: f!,
                                ),
                              ));
                          a.clear();
                          b.clear();
                          c.clear();
                          d.clear();
                          file = null;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter File Also")));
                      }
                    }
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
