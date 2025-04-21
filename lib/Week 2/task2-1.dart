import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pocketcoach/Week%202/task2-1-1.dart';

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
      appBar: AppBar(
        title: Text("Task1(Data Pass Between 2 page)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.grey.shade300,
          child: SingleChildScrollView(
            child: Form(
              key: k,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      child: GestureDetector(
                        onTap: select,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.blueAccent.withOpacity(0.2),
                                backgroundImage: file != null
                                    ? FileImage(file!)
                                    : AssetImage("assets/img_7.png")
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children:[
                          Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (a) {
                              if (a == null || a.isEmpty) {
                                return "Plz Enter Roll no Its Required";
                              }
                              return null;
                            },
                            maxLength: 10,
                            controller: a,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              labelText: 'Roll No',
                              hintText: 'Enter your Roll No',
                              prefixIcon: Icon(Icons.onetwothree),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                labelText: 'Name',
                                hintText: 'Enter your Name',
                                prefixIcon: Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
                            ),
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                labelText: 'City',
                                hintText: 'Enter your City',
                                prefixIcon: Icon(Icons.location_city),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: d,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 8) {
                                  return """Password must contain at least 8
characters, uppercase, lowercase, 
digit, and special character""";
                                }
                                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                  return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
                                }
                                if (!RegExp(r'[a-z]').hasMatch(value)) {
                                  return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
                                }
                                if (!RegExp(r'[0-9]').hasMatch(value)) {
                                  return """Password must contain at least 8 characters, 
uppercase, lowercase, digit, and special character""";
                                }
                                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                                  return """Password must contain at least 8 characters, 
uppercase, lowercase, digit, and special character""";
                                }
                                return null;
                              },
                              maxLength: 15,
                              obscureText: show,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
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
                                prefixIcon: Icon(Icons.password),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                              ),
                            ),
                          ),]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 10,shadowColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),backgroundColor: Colors.blueAccent),
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
                                  SnackBar(content: Text("Enter File Also"),duration: Duration(milliseconds: 300),));
                            }
                          }
                        },
                        child: Text("Submit",
                            style: TextStyle(color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
