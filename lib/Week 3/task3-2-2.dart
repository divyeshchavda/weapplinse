import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dbhelper.dart';

class task322 extends StatefulWidget {
  final int id;
  final String? nameg;
  final String? emailg;
  final String? passg;
  final Uint8List? imageg;

  task322({
    required this.id,
    this.nameg,
    this.emailg,
    this.passg,
    this.imageg,
  });

  @override
  State<task322> createState() => _task322State();
}

class _task322State extends State<task322> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbHelper = dbhelper2();
  Uint8List? _selectedImageBytes;
  bool show=true;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _nameController.text = widget.nameg ?? '';
    _emailController.text = widget.emailg ?? '';
    _passwordController.text = widget.passg ?? '';
    _selectedImageBytes = widget.imageg;
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _selectedImageBytes = File(result.files.single.path!).readAsBytesSync();
      });
    } else {
      _showMessage("No file selected.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),duration: Duration(milliseconds: 500),));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool check = await _dbHelper.checkEmailExists2(_emailController.text, excludeId: widget.id);
      if (check) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email Already exists"), duration: Duration(milliseconds: 500)),
        );
      } else {
        try {
          await _dbHelper.update(
            widget.id,
            _nameController.text.isNotEmpty ? _nameController.text : null,
            _emailController.text.isNotEmpty ? _emailController.text : null,
            _passwordController.text.isNotEmpty ? _passwordController.text : null,
            _selectedImageBytes,
          );

          _showMessage("Data updated successfully.");
          Navigator.pop(context);
        } catch (e) {
          _showMessage("Error updating data: $e");
        }
      }
    }
  }


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required.";
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email.";
    return null;
  }

  String? _validatePassword(String? value) {
      if (value!.isEmpty) {
        return 'Please enter a password';
      }
      if (value.length < 8) {
        return """Password must contain at least 8 characters, 
                                uppercase, lowercase, digit, and special character""";
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return """Password must contain at least 8 characters, 
                                uppercase, lowercase, digit, and special character""";
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return """Password must contain at least 8 characters, 
                                uppercase, lowercase, digit, and special character""";
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Data"),centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,),
      body:SingleChildScrollView(
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
                          backgroundImage: _selectedImageBytes != null
                              ? MemoryImage(_selectedImageBytes!)
                              : AssetImage("assets/img_7.png"),
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
                        labelText: "Full Name",
                        hintText: "Enter Full Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
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
                    TextFormField(
                      controller: _passwordController,
                      obscureText: show,
                      maxLength: 15,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
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
                        border: OutlineInputBorder(),
                      ),
                      validator: _validatePassword,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
