import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'api.dart';
import 'dbhelper.dart';


class task321 extends StatefulWidget {
  const task321({super.key});

  @override
  State<task321> createState() => _task321State();
}

class _task321State extends State<task321> {
  final k = GlobalKey<FormState>();
  final t = GlobalKey<FormState>();
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  final db = dbhelper2();
  bool _isPasswordVisible = false;
  var error = "";
  List<Map<String, dynamic>> l = [], g = [];
  File? file;
  var rno;
  bool show=true;
  Icon? eye;
  var name = "", city = "", rnos = "", pass = "", f = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        title: Text("Task2(Insert data)"),
        centerTitle: true,
      backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: t,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add Data",style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.width *
                            0.10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: file!=null?FileImage(file!):AssetImage("assets/img_7.png")
                        ),
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.blueAccent,
                          onPressed: select,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: b,
                      validator: (value) =>
                      value!.isEmpty
                          ? 'Enter your name'
                          : null,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        hintText: "Enter Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: c,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                      value!.isEmpty ||
                          !RegExp(r"^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)
                          ? 'Enter a valid email'
                          : null,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
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
                      obscureText: show,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        suffixIcon: IconButton(onPressed: (){
                          if(show==true){
                            setState(() {
                              show=false;
                            });
                          }
                          else{
                            setState(() {
                              show=true;
                            });
                          }
                        }, icon: show==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined)),
                        labelText: "Password",
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (t.currentState?.validate() ?? false) {
                          bool check=await db.checkEmailExists(c.text);
                          if(check){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Already exist"),duration: Duration(milliseconds: 500),));
                          }
                          else
                          {
                            if (file != null) {
                              final imageBytes = await file!.readAsBytes();
                              setState(() {
                                name = b.text.toString();
                                city = c.text.toString();
                                pass = d.text.toString();
                              });

                              db.add(name, city, pass, imageBytes);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Inserted Successfully",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                                duration: Duration(milliseconds: 500),
                                shape: Border.all(color: Colors.black),
                              ));

                              a.clear();
                              b.clear();
                              c.clear();
                              d.clear();
                              setState(() {
                                file = null;
                              });
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Select File Also"),duration: Duration(milliseconds: 500),),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Save Changes",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
