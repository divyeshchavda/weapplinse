import 'dart:core';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'api.dart';

class task332 extends StatefulWidget {
  const task332({super.key});

  @override
  State<task332> createState() => _task332State();
}

class _task332State extends State<task332> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String error = "";
  bool? check = false;
  File? selectedFile;
  late Future<List<dynamic>> data;

  final Api = api();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    data = api.fetch();
    setState(() {});
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image);

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        error = "";
      });
    } else {
      setState(() {
        error = "No file selected. Please choose a file.";
      });
    }
  }

  Future<void> submitData() async {
    final email = emailController.text;

    List<dynamic> users = await api.fetch();
    bool emailExists = users.any((user) => user['email'] == email);

    if (emailExists) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists. Please use a different email.")));
      });
    } else {
      if (formKey.currentState?.validate() ?? false) {
        if (selectedFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please choose a file.')),
          );
        } else {
          // Process submission
          final name = nameController.text;
          setState(() {
            error = "";
          });

          await api.add(name: name, email: email, pic: selectedFile!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Data successfully inserted!",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
          nameController.clear();
          emailController.clear();
          setState(() {
            selectedFile = null;
          });
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("ADD DATA"), centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,),
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
                key: formKey,
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
                      backgroundImage: selectedFile!=null?FileImage(selectedFile!):AssetImage("assets/img_7.png")
                    ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.blueAccent,
                        onPressed: selectFile,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      validator: (value) =>
                      value!.isEmpty
                          ? 'Enter your name'
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        labelText: "Full Name",
                        hintText: "Enter Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                      value!.isEmpty ||
                          !RegExp(r"^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)
                          ? 'Enter a valid email'
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        labelText: "Email",
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitData,
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
