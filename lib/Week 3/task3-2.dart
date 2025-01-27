import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/task3-2-1.dart';
import 'package:weapplinse/Week%203/task3-2-2.dart';
import 'package:weapplinse/Week%203/task3-2-3.dart';
import 'package:weapplinse/Week%203/task3-2-4.dart';
import 'package:file_picker/file_picker.dart';
import 'api.dart';
import 'dbhelper.dart';
import 'dart:typed_data';

class task32 extends StatefulWidget {
  const task32({super.key});

  @override
  State<task32> createState() => _task32State();
}

class _task32State extends State<task32> {
  final k = GlobalKey<FormState>();
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  final db = dbhelper2();
  bool _isPasswordVisible = false;
  var error = "";
  List<Map<String, dynamic>> l = [], g = [];
  Uint8List? fileData;

  void clear() {
    setState(() {
      a.clear();
      b.clear();
      c.clear();
      d.clear();
      fileData = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("State Disposed");
  }

  void set(String name, String email, String pass, Uint8List? imageData) {
    setState(() {
      b.text = name;
      c.text = email;
      d.text = pass;
      fileData = imageData;
    });
  }

  Future<void> select() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        fileData = result.files.single.bytes;
        error = "File selected.";
      });
    } else {
      setState(() {
        error = "No file selected.";
      });
    }
  }

  var rno;
  var name = "", city = "", rnos = "", pass = "", f = "";

  @override
  void initState() {
    super.initState();
    disp();
  }

  void disp() async {
    l = await db.display();
    setState(() {});
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Task32 (SQLITE)"),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: k,
        child: Column(
          children: [
            Expanded(
                flex: 8,
                child: Container(
                  color: Colors.white,
                  child: l.isEmpty
                      ? Center(
                    child: Text(
                      "NO DATA FOUND",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontStyle: FontStyle.italic),
                    ),
                  )
                      : ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      final b = l[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListTile(
                            title: Text(
                              "${b['name']}",
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.06,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${b['email']}",
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.03,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.black12,
                              child: b['image'] != null
                                  ? Image.memory(
                                b['image'] as Uint8List,
                                fit: BoxFit.fitHeight,
                              )
                                  : Icon(Icons.image_not_supported),
                            ),
                            trailing: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => task322(
                                            id: b['rno'],
                                            nameg: b['name'],
                                            emailg: b['email'],
                                            passg: b['password'],
                                            imageg: b['image'],
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
                                            content: const Text(
                                                "Are you sure you want to delete this item?"),
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
                                                  setState(() {
                                                    db.delete(b['rno']);
                                                    disp();
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        "Deleted Successfully",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.05,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Colors.white),
                                                      ),
                                                      duration:
                                                      Duration(seconds: 2),
                                                      shape: Border.all(
                                                          color: Colors.black),
                                                    ));
                                                  });
                                                },
                                                style: TextButton.styleFrom(
                                                    foregroundColor: Colors.red),
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
                )),
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
                          child: InkWell(
                              onTap: () async {
                                clear();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => task321(),
                                    ));
                                disp();
                              },
                              child: Icon(
                                Icons.add,
                                size: 40,
                              )),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> get(int rno) async {
    g = await db.displayd(rno);
    setState(() {});
    print(g);
  }
}
