import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:weapplinse/Week%203/api2.dart';
import 'package:weapplinse/Week%203/task3-3-2.dart';
import 'package:weapplinse/Week%203/task3-3-4.dart';
import 'package:weapplinse/Week%203/task3-1-2-2.dart';

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
  var error="";
  final fetch = api();
  var rno;
  var name = "", email = "", pic = "";
  File? file;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _profilePic;
  late Future<List<dynamic>> data;

  void initState() {
    super.initState();
    disp(); // Fetch the list of users
  }
  void disp(){
    data = api.fetch();
    setState(() {

    });
    print(data);
  }
  Future<void> select() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
    else {
// User canceled the picker
      setState(() {
        error = "No file selected.";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              child: FutureBuilder<List<dynamic>>(
                future: data,
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
                      child: Text("NO DATA FOUND"),
                    );
                  } else {
                    final user = snapshot.data!;
                    return ListView.builder(
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        final b = user[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                            child: ListTile(
                              title: Text(b["name"]),
                              subtitle: Text(b['email']),
                              leading: b['profile_pic'] != null
                                  ? Container(color: Colors.black12,width: 80,height: 80,
                                  child: Image.network(b['profile_pic'], fit: BoxFit.fitHeight,))
                                  : CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              trailing: Container(
                                width: 100,

                                decoration: BoxDecoration(
                                    color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Row(
                                  children: [
                                    IconButton(onPressed: () async {
                                      await Navigator.push(context, MaterialPageRoute(builder: (context) => task334(id: b['user_id'].toString(), nameg: b["name"], emailg: b['email'], imageg: b['profile_pic']),));
                                      setState(() {
                                        data = api.fetch();
                                      });
                                    }, icon: Icon(Icons.edit)),
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
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
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
                    );
                  }
                },
              ),
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        width: 65,
                        height: 100,
                        child: GestureDetector(onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => task332(),));
                          setState(() {
                            data=api.fetch();
                          });
                        },child: Icon(Icons.add,size: 40,)),
                      )),
                ),
              ))
        ],
      ),
    );
  }
  Future show2() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ADD Data"),
          content: Form(
            key: k,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (a) {
                        if (a == null || a.isEmpty) {
                          return "Plz Enter Name Its Required";
                        }
                        return null;
                      },
                      controller: a,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(Icons.person),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (a) {
                        if (a == null || a.isEmpty) {
                          return "Plz Enter Email Its Required";
                        }
                        else if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(a)){
                          return "Plz Valid Email Its Required";
                        }
                        return null;
                      },
                      controller: b,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(Icons.alternate_email),
                      )),
                ),
                ElevatedButton(
                    onPressed: () {
                      select();
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.file_present_sharp,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("PickFile",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    )),
                Text(error,style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()  async {
                        if (k.currentState?.validate() ?? false ) {
                          if(file==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Enter File Also')),
                            );
                          }
                          else {
                            setState(() {
                              name = a.text.toString();
                              email = b.text.toString();
                              pic = file.toString();
                              print("$name+$email+$pic");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("INSERTED SUCCESSFULLY",
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white)),
                                duration: Duration(seconds: 2),
                                shape: Border.all(color: Colors.black),
                              ));
                              data = api.fetch();
                            });
                            api.add(name: name, email: email, pic: file!);
                            print("Success");
                            a.clear();
                            b.clear();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text("Submit",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.06,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          ),
          scrollable: true,
        );
      },
    );
  }
  Future show(String id) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit Data"),
        content: Column(
          children: [
            TextField(
              controller: a,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: b,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () async {
              FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
              if (result != null) {
                setState(() {
                  file = File(result.files.single.path!);
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
              if (a.text.isEmpty ||
                  b.text.isEmpty || file == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Enter All Fields')),
                );
              }
              else {
                final response= await api.edit(Id: id, name: a.text.toString(), email: b.text.toString(), pic: file!);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User details updated successfully')),
                  );
                  setState(() {
                    data = api.fetch(); // Refresh user list
                  });
                  a.clear();
                  b.clear();
                  file=null;
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
        scrollable: true,
      );
    },);
  }
  Future<void> _confirmDelete(String userId) async {
    setState(() {
      data = data.then((userList) {
        return userList.where((user) => user['user_id'] != userId).toList();
      });
    });

    await api.delete(id: userId);
  }
}
