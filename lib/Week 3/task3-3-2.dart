import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

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
        error = "Email already exists. Please use a different email.";
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
      appBar: AppBar(title: Text("ADD DATA"),),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
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
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a name"
                          : null,
                      controller: nameController,
                      maxLength: 30,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email";
                        }
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                            .hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      controller: emailController,
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(width: 120,height: 120, decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),child: selectedFile!=null?Image.file(selectedFile!,fit: BoxFit.fitHeight,):Center(child: Text("NO FILE SELECTED",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 12)))),
                        ),
                        Positioned(
                          top: 90,
                          left: 80,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: CircleBorder()),
                              onPressed: () {selectFile();}, child: Icon(Icons.camera_alt,color: Colors.white,size: 20,)),
                        )
                      ],
                    ),
                  ),
                  Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: submitData,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
