import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pocketcoach/Week%203/task3-3-2.dart';
import 'package:pocketcoach/Week%203/task3-3-4.dart';

import 'api.dart';


class task331 extends StatefulWidget {
  const task331({super.key});

  @override
  State<task331> createState() => _task331State();
}

class _task331State extends State<task331> {
  final k = GlobalKey<FormState>();
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  var error = "";
  final fetch = api();
  var rno;
  var name = "", email = "", pic = "";
  File? file;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _profilePic;

  List<dynamic> userList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    disp();
  }

  void disp() async {
    List<dynamic> users = await api.fetch();
    setState(() {
      userList = users;
      isLoading = false;
    });
  }

  Future<void> _confirmDelete(String userId) async {
    setState(() {
      userList.removeWhere((user) => user['user_id'].toString() == userId);
    });

    await api.delete(id: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 8,title: Text("API"),actions: [Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => task332()),
                    );
                    disp();
                  },
                  child: Icon(Icons.add, size: 30),
                ),
              ),
            ),
          ),
        ),
      ),],),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : userList.isEmpty
                ? Center(child: Text("NO DATA FOUND"))
                : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final b = userList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey.shade300,
                    shadowColor: Colors.black,
                    elevation: 10,
                    child: ListTile(
                      title: Text(b["name"]),
                      subtitle: Text(b['email']),
                      leading:
                      CircleAvatar(radius: 30,backgroundImage: b['profile_pic'] != null
                          ? NetworkImage(b['profile_pic'] ,)
                          : AssetImage("assets/img_7.png")),
                      trailing: Card(
                        elevation: 5,
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => task334(
                                        id: b['user_id'].toString(),
                                        nameg: b["name"],
                                        emailg: b['email'],
                                        imageg: b['profile_pic'],
                                      ),
                                    ),
                                  );
                                  disp();
                                },
                                icon: Icon(Icons.edit,color: Colors.blueAccent,),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm Delete"),
                                        content: const Text("Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _confirmDelete(b['user_id'].toString());
                                            },
                                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete,color: Colors.red,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
