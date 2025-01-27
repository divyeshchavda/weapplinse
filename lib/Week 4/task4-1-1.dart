import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%203/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weapplinse/Week%203/api2.dart';
import 'package:weapplinse/Week%203/task3-3-2.dart';
import 'package:weapplinse/Week%203/task3-3-4.dart';
import 'package:weapplinse/Week%203/task3-1-2-2.dart';

class task411 extends StatefulWidget {
  const task411({super.key});

  @override
  State<task411> createState() => _task411State();
}

class _task411State extends State<task411> {
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
        title: Text("Week 4(Lazy Loading)"),
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
                              leading:Container(width: 65,height: 100,color: Colors.black12,
                                child: CachedNetworkImage(
                                  imageUrl: b['profile_pic'],
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(
                                      Icons.error,
                                      size: 30,
                                    ),
                                  ),
                                  fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}
