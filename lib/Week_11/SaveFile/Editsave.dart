import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class editsave extends StatefulWidget {
  final int id;
  final String fileName;
  final String filePath;
  final String initialContent;
  final VoidCallback onFileUpdated;

  const editsave({
    Key? key,
    required this.fileName,
    required this.filePath,
    required this.initialContent,
    required this.onFileUpdated,
    required this.id,
  }) : super(key: key);

  @override
  State<editsave> createState() => _editsaveState();
}

class _editsaveState extends State<editsave> {
  var content = TextEditingController();
  var title = TextEditingController();
  List files=[];
  final k = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    content.text = widget.initialContent;
    title.text = widget.fileName.substring(0, widget.fileName.length - 4);
    requestStoragePermission();
    getfile();
  }

  Future<bool> fileexist(String name) async{
    return files.any((file) => file.toLowerCase() == "$name.txt".toLowerCase());
  }

  Future<void> getfile() async {
    Directory musicDir = Directory("/storage/emulated/0/FILES/");

    if (musicDir.existsSync()) {
      List<FileSystemEntity> FILE = musicDir.listSync(recursive: false);

      // Get only .txt files and extract names
      List<String> fileNames = FILE.where((file) {
        return file.path.toLowerCase().endsWith(".txt");
      }).map((file) => path.basename(file.path)).toList();

      setState(() {
        files = fileNames;
      });
      files.removeAt(widget.id);

      print("File Names: $files");
    } else {
      print("Files folder not found!");
    }
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  Future<void> updateFile({
    required String oldFileName,
    required String newFileName,
    required String newContent,
  }) async {
    // Ensure permission is granted
    if (await Permission.manageExternalStorage.request().isGranted) {
      try {
        // Path to the directory
        String directoryPath = "/storage/emulated/0/FILES/";

        // Old and new file paths
        String oldFilePath = path.join(directoryPath, oldFileName);
        String newFilePath = path.join(directoryPath, "$newFileName.txt");

        File oldFile = File(oldFilePath);

        if (await oldFile.exists()) {

          await oldFile.writeAsString(newContent);
          print("✅ Content updated successfully.");


          if (oldFileName != newFileName) {
            File newFile = await oldFile.rename(newFilePath);
            print("✅ File renamed to: ${newFile.path}");
            widget.onFileUpdated();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('File updated successfully!'),duration: Duration(milliseconds: 500),),
            );

            Navigator.pop(context);
          }
        } else {
          print("❌ Error: File not found!");
        }
      } catch (e) {
        print("❌ Error: $e");
      }
    } else {
      print("❌ Permission not granted");
    }
  }
  // Future<void> updateFileContent(String fileName, String content) async {
  //   try {
  //     if (!(await requestStoragePermission())) {
  //       print("❌ Storage permission not granted");
  //       return;
  //     }
  //
  //     final file = File(widget.filePath);
  //
  //     if (await file.exists()) {
  //       await file.writeAsString(content);
  //       print("✅ File updated successfully at: ${widget.filePath}");
  //
  //       widget.onFileUpdated();
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('File updated successfully!')),
  //       );
  //
  //       Navigator.pop(context); // Return to the previous screen
  //     } else {
  //       print("❌ File not found: ${widget.filePath}");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Error: File not found!')),
  //       );
  //     }
  //   } catch (e) {
  //     print("❌ Error updating file: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update File"),
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
                    bool filee=await fileexist(title.text);
                    print(filee);
                    if(k.currentState?.validate() ?? false){
                      if (title.text.isNotEmpty == true &&
                          content.text.isNotEmpty == true)
                      {
                        if (filee == false) {
                          updateFile(
                            oldFileName: widget.fileName,
                            newFileName: title.text,
                            newContent: content.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('File Name Already Exist'),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        }
                      }
                      else {
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
                    "Update",
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
