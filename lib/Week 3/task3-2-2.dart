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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required.";
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email.";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required.";
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return """Password must  including uppercase, 
lowercase, digit, and special character.""";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Data")),
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
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Text("UPDATE DATA",style: TextStyle(
                        fontSize:
                        MediaQuery.of(context).size.width *
                            0.10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Name is required." : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: show,
                    maxLength: 15,
                    decoration: InputDecoration(
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
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(width: 120,height: 120, decoration: BoxDecoration(
                                color: Colors.black12,
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: const BorderRadius.all(Radius.circular(5))
                            ),child: _selectedImageBytes != null
                                ? Image.memory(
                              _selectedImageBytes!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ):Center(child: Text("NO FILE SELECTED",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),))),
                          ),
                          Positioned(
                            top: 90,
                            left: 80,
                            child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: CircleBorder()),
                                onPressed: _selectFile, child: Icon(Icons.camera_alt,color: Colors.white,size: 20,)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: _submitForm,
                    child: Text("Submit",style: TextStyle(
                    fontSize:
                    MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
                ],
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
