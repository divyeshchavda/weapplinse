import 'dart:io';

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
                      ? Container(width: 80,
                      child: Image.network(b['profile_pic'], fit: BoxFit.fill,))
                      : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  trailing: IconButton(onPressed: () {
                    _confirmDelete(b['user_id'].toString());
                  }, icon: Icon(Icons.delete)),

                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _confirmDelete(String userId) async {
    await api.delete(id: userId); // Call the delete method
    setState(() {
      a = api.fetch(); // Refresh the user list
    }
    );
  }
}
