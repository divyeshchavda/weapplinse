import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketcoach/Week_11/SaveFile/Editsave.dart';

import 'Addsave.dart';

class save extends StatefulWidget {
  const save({super.key});

  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  var title = TextEditingController();
  var content = TextEditingController();
  var editcontent = TextEditingController();
  String filePath = '';
  List files = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestStoragePermission();
    saveToCustomLocation();
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  Future<String> readFileContent(String filePath) async {
    try {
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      print("Error reading file: $e");
      return "Error reading file";
    }
  }

  Future<void> saveToCustomLocation() async {
    Directory musicDir = Directory("/storage/emulated/0/FILES/");
    if (musicDir.existsSync()) {
      List<FileSystemEntity> FILE = musicDir.listSync(recursive: false);
      List<FileSystemEntity> audioList = FILE.where((file) {
        String path = file.path.toLowerCase();
        return path.endsWith(".txt");
      }).toList();
      setState(() {
        files = audioList;
      });
      print(files);
    } else {
      print("Files folder not found!");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Files/Get Files From Local"),
        actions: [
          Container(
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
                      child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => addsave(),
                                ));
                            saveToCustomLocation();
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                          )),
                    ),
                  )),
            ),
          )
        ],
      ),
      body: files.isEmpty
          ? Center(child: Text("No files found"))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 6,
                    child: ListTile(
                      onTap: () async {
                        String content =
                        await readFileContent(files[index].path);
                        showDialog(context: context, builder: (context) {
                          return dialog(files[index].path.split('/').last.toString(),content);
                        },);
                      },
                      title: Text(
                        files[index].path.split('/').last.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      subtitle: Text("FILES"),
                      leading: Lottie.asset("assets/files.json"),
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
                                  String content =
                                      await readFileContent(files[index].path);
                                  // editcontent.text=content;
                                  // showDialog(context: context, builder: (context) {
                                  //   return dialog(files[index].path.split('/').last.toString(),content,files[index].toString());
                                  // },);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editsave(
                                          fileName: files[index]
                                              .path
                                              .split('/')
                                              .last
                                              .toString(),
                                          filePath:
                                              files[index].path.toString(),
                                          initialContent: content,
                                          onFileUpdated: saveToCustomLocation, id: index,),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
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
                                            onPressed: () async {
                                              try {
                                                final file = File(files[index]
                                                    .path
                                                    .toString());

                                                if (await file.exists()) {
                                                  await file.delete();
                                                  print(
                                                      "✅ File deleted successfully: $filePath");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                        'Deleted Successfully',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                    ),
                                                  );
                                                  saveToCustomLocation();
                                                  Navigator.pop(context);
                                                } else {
                                                  print(
                                                      "❌ File not found: $filePath");
                                                }
                                              } catch (e) {
                                                print(
                                                    "❌ Error deleting file: $e");
                                              }
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
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
    );
  }

  dialog(String name,String content) {
    return AlertDialog(
      scrollable: true,
      title:  Center(
        child: Text("DATA OF FILE",style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black),),
      ),
      content: Column(
        children: [
          Text("Filename: $name",style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black),),
          Text("Content: $content",style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black),),
        ],
      ),
    );
  }

  // dialog(String filename,String content,String filepath) {
  //   return AlertDialog(
  //     scrollable: true,
  //     title: Center(
  //       child: Text(filename, style: GoogleFonts.poppins(
  //           fontSize: 15,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.black),),
  //     ),
  //     content: TextField(
  //       controller: editcontent,
  //       maxLength: 500,
  //       maxLines: 15,
  //       decoration: InputDecoration(
  //         filled: true,
  //         fillColor: Colors.white,
  //         labelText: "Content",
  //         hintText: "Enter Content",
  //         border:
  //         OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       Center(
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             backgroundColor: Colors.black,
  //           ),
  //           onPressed: () {
  //             if(editcontent.text.isNotEmpty==true){
  //               updateFileContent(filename, content, filepath);
  //             }
  //             else{
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   content: Text('Insert Data Its Compulsory'),
  //                   duration: Duration(milliseconds: 500),
  //                 ),
  //               );
  //             }
  //           },
  //           child: Text(
  //             "Update",
  //             style: GoogleFonts.poppins(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
