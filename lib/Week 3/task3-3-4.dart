import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/api.dart';

class task334 extends StatefulWidget {
  const task334({super.key});

  @override
  State<task334> createState() => _task334State();
}

class _task334State extends State<task334> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _profilePic;
  late Future<List<dynamic>> a;

  @override
  void initState() {
    super.initState();
    a = api.fetch();
    print(a); // Fetch the list of users
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2(Display & EDIT data)"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: a,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.hasError}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("NO DATA"),
            );
          } else {
            final user = snapshot.data!;
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final b = user[index];
                return ListTile(
                  title: Text(b["name"]),
                  subtitle: Text(b['email']),
                  leading: b['profile_pic'] != null
                      ? Container(width: 80,child: Image.network(b['profile_pic'],fit: BoxFit.fill))
                      : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  trailing: IconButton(onPressed: () {
                    show(b['user_id'].toString());
                  }, icon: Icon(Icons.edit)),

                );
              },
            );
          }
        },
      ),
    );
  }


  Future show(String id) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit Data"),
        content: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () async {
              FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
              if (result != null) {
                setState(() {
                  _profilePic = File(result.files.single.path!);
                });
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Enter File Also')),
                );
              }
            }, child: Row(children: [
              Icon(Icons.file_present_sharp),
              Text("File")
            ],)),
            ElevatedButton(onPressed: () async {
              if (_nameController.text.isEmpty ||
                  _emailController.text.isEmpty || _profilePic == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Enter All Fields')),
                );
              }
              else {
                final response= await api.edit(Id: id, name: _nameController.text.toString(), email: _emailController.text.toString(), pic: _profilePic!);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User details updated successfully')),
                  );
                  setState(() {
                    a = api.fetch(); // Refresh user list
                  });
                  _nameController.clear();
                  _emailController.clear();
                  _profilePic=null;
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update user: ${response.body}')),
                  );
                }
              }
            }, child: Text("SAVE"))
          ],
        ),
      );
    },);
  }
}
