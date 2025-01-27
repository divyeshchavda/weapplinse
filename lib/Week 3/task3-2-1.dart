import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-2-1.dart';
import 'package:weapplinse/Week%203/task3-2-2.dart';
import 'package:weapplinse/Week%203/task3-2-3.dart';
import 'package:weapplinse/Week%203/task3-2-4.dart';
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
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: t,
              child: Column(
                children: [
                  Text("INSERT DATA",style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width *
                          0.10,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (a) {
                          if (a == null || a.isEmpty) {
                            return "Plz Enter Name Its Required";
                          }
                          return null;
                        },maxLength: 20,
                        controller: b,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                          } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                              .hasMatch(a)) {
                            return "Plz Valid Email Its Required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: c,maxLength: 30,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.alternate_email),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (a) {
                        if (a == null || a.isEmpty) {
                          return 'Password is required';
                        }
                        if (a.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(a!)) {
                          return """Password is Must Contain 
uppercase,lowercase,digit and 
special character""";
                        }
                        return null;
                      },
                      controller: d,maxLength: 15,
                      obscureText: show,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.password),
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
                          }, icon: show==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined))
                      ),
                    ),),
                  Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(width: 120,height: 120, decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),child: file!=null?Image.file(file!,fit: BoxFit.cover,):Center(child: Text("NO FILE SELECTED",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),))),
                        ),
                        Positioned(
                          top: 90,
                          left: 80,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: CircleBorder()),
                              onPressed: () {select();}, child: Icon(Icons.camera_alt,color: Colors.white,size: 20,)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: () async {
                          if (t.currentState?.validate() ?? false) {
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
                                duration: Duration(seconds: 2),
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
                                SnackBar(content: Text("Select File Also")),
                              );
                            }
                          }
                        },
                        child: Text("Submit",
                            style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.06,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,color: Colors.white))),
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
