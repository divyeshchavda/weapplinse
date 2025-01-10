import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For selecting profile picture
import 'api2.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = ApiService.getUserList();
    print(_userList);// Fetch the list of users
  }

  // Method to edit user
  Future<void> _editUser(String userId) async {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    File? _profilePic;

    // Pick image for editing profile picture
    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profilePic = File(pickedFile.path);
        });
      }
    }

    // Show dialog to edit user details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
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
              _profilePic == null
                  ? Text('No image selected.')
                  : Image.file(_profilePic!, height: 100),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Profile Picture'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isEmpty || _emailController.text.isEmpty || _profilePic == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('All fields are required')),
                  );
                  return;
                }

                try {
                  final response = await ApiService.editUser(
                    userId: userId,
                    name: _nameController.text,
                    email: _emailController.text,
                    profilePic: _profilePic!,
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User details updated successfully')),
                    );
                    setState(() {
                      _userList = ApiService.getUserList(); // Refresh user list
                    });
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
              },
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: FutureBuilder<List<dynamic>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  leading: user['profile_pic'] != null
                      ? Image.network(user['profile_pic'])
                      : Icon(Icons.person),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editUser(user['user_id'].toString()),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
