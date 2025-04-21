import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%203/task3-3-2.dart';
import 'package:pocketcoach/Week%203/task3-3-4.dart';


import 'api.dart';

void main(){
  runApp(MaterialApp(home: Task331(),));
}

class Task331 extends StatefulWidget {
  const Task331({super.key});

  @override
  State<Task331> createState() => _Task331State();
}

class _Task331State extends State<Task331> {
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
      isLoading = false; // Stop loading after fetching data
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
      appBar: AppBar(title: Text("API")),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ListTile(
                      title: Text(b["name"]),
                      subtitle: Text(b['email']),
                      leading: b['profile_pic'] != null
                          ? Container(
                        color: Colors.black12,
                        width: 80,
                        height: 80,
                        child: Image.network(b['profile_pic'], fit: BoxFit.fitHeight),
                      )
                          : CircleAvatar(child: Icon(Icons.person)),
                      trailing: Container(
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
                              icon: Icon(Icons.edit),
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
                              icon: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    width: 65,
                    height: 100,
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => task332()),
                        );
                        disp();
                      },
                      child: Icon(Icons.add, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


