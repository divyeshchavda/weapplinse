import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pocketcoach/Week%203/task3-2-1.dart';
import 'package:pocketcoach/Week%203/task3-2-2.dart';
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
        title: Text("Task32 (SQLITE)"),
        elevation: 8,
actions: [Container(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
        alignment: Alignment.topRight,
        child: Card(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(Radius.circular(15))),
            width: 50,
            height: 50,
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
                  size: 30,
                )),
          ),
        )),
  ),
)],
      ),
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
                        child: Card(
                          color: Colors.grey.shade300,
                          shadowColor: Colors.black,
                          elevation: 10,
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
                            leading: CircleAvatar(radius: 30,backgroundImage: b['image'] != null
                                ? MemoryImage(b['image'] as Uint8List,)
                                : AssetImage("assets/img_7.png")),
                            trailing: Card(
                              elevation: 5,
                              child: Container(
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
                                      icon: Icon(Icons.edit,color: Colors.blueAccent,),
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
                )),
          ],
        ),
      ),
    );
  }

}
