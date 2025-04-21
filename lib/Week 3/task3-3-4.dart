import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'api.dart';


class task334 extends StatefulWidget {
  final String? id;
  final String? nameg;
  final String? emailg;
  final String? imageg;

  task334({required this.id, required this.nameg, required this.emailg, required this.imageg});

  @override
  State<task334> createState() => _task334State();
}
class _task334State extends State<task334> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  File? _selectedFile;
  bool _isFileSelected = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.nameg ?? '';
    _emailController.text = widget.emailg ?? '';
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _isFileSelected = true;
      });
    }
  }

  Future<void> _updateDetails() async {
    final email = _emailController.text;

    List<dynamic> users = await api.fetch();
    print("BEFORE");
    print(users);
    users.removeWhere((user) => user["user_id"] == int.parse(widget.id!));
    print("AFTER");
    print(users);
    bool emailExists = users.any((user) => user['email'] == email );
    print(emailExists);
    bool emailExists2 = users.any((user) => user['user_id'] != widget.id);
    print(emailExists2);
    if(emailExists){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists. Please use a different email."),duration: Duration(milliseconds: 300),));
      });
    }
    else{
      if (_formKey.currentState!.validate()) {
        try {
          final response = await api.edit(
            Id: widget.id!,
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            pic: _isFileSelected ? _selectedFile! : null,
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User details updated successfully'),duration: Duration(milliseconds: 500),),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to update user: ${response.body}')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all required fields')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Update Data",style: TextStyle(
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
                          backgroundImage: _isFileSelected
                              ? FileImage(_selectedFile!)
                              : widget.imageg != null
                              ? NetworkImage(widget.imageg!)
                              : AssetImage("assets/default_user.png"),
                        ),
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.blueAccent,
                          onPressed: _selectFile,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) => value!.isEmpty ? 'Enter your name' : null,
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty || !RegExp(r"^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateDetails,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
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

