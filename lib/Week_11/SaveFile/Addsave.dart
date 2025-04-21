import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class addsave extends StatefulWidget {
  const addsave({super.key});

  @override
  State<addsave> createState() => _addsaveState();
}

class _addsaveState extends State<addsave> {
  var title = TextEditingController();
  var content = TextEditingController();
  String filePath = '';
  List files = [];
  final k = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestStoragePermission();
    getfile();
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  Future<bool> fileexist(String name) async {
    return files.any((file) => file.toLowerCase() == "$name.txt".toLowerCase());
  }

  Future<void> saveToCustomLocation(String fileName, String content) async {
    try {
      final file = File('/storage/emulated/0/FILES/$fileName.txt');
      await file.writeAsString(content);
      setState(() => filePath = file.path);
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  Future<void> getfile() async {
    Directory musicDir = Directory("/storage/emulated/0/FILES/");

    if (musicDir.existsSync()) {
      List<FileSystemEntity> FILE = musicDir.listSync(recursive: false);

      // Get only .txt files and extract names
      List<String> fileNames = FILE
          .where((file) {
            return file.path.toLowerCase().endsWith(".txt");
          })
          .map((file) => path.basename(file.path))
          .toList();

      setState(() {
        files = fileNames;
      });

      print("File Names: $files");
    } else {
      print("Files folder not found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add File"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: k,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value!)) {
                        return "Only letters, numbers, '-' and '_' are allowed";
                      }
                      return null;
                    },
                    controller: title,
                    maxLength: 20,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title",
                      hintText: "Enter Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: content,
                    maxLength: 500,
                    maxLines: 15,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Content",
                      hintText: "Enter Content",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    bool filee = await fileexist(title.text);
                    print(filee);
                    if (k.currentState?.validate() ?? false){
                      if (title.text.isNotEmpty == true &&
                          content.text.isNotEmpty == true) {
                        if (filee == false) {
                          saveToCustomLocation(title.text, content.text);
                          title.clear();
                          content.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Saved Successfully'),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File Name Already Exist'),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Insert Data Its Compulsory'),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
