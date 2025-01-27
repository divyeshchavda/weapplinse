import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/api.dart';

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  Future<void> _updateDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await api.edit(
          Id: widget.id!,
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          pic: _isFileSelected?_selectedFile!:null,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User details updated successfully')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update user: ${response.body}')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("UPDATE DATA",style: TextStyle(
                      fontSize:
                      MediaQuery.of(context).size.width *
                          0.10,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a name' : null,
                    maxLength: 30,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter an email'
                        : !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                        ? 'Please enter a valid email'
                        : null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _isFileSelected
                                ? Image.file(_selectedFile!, fit: BoxFit.cover)
                                : widget.imageg != null
                                ? Image.network(widget.imageg!, fit: BoxFit.cover)
                                : Center(child: Text('No Image Selected')),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 80,
                          child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: CircleBorder()),
                              onPressed: () {_selectFile();}, child: Icon(Icons.camera_alt,color: Colors.white,size: 20,)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updateDetails,
                    child: Text('Save'),
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
