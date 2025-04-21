import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mime/mime.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Week 2/helper2.dart';

class task61 extends StatefulWidget {
  const task61({super.key});

  @override
  State<task61> createState() => _task61State();
}

class _task61State extends State<task61> {
  static const platform = MethodChannel("whatsapp_share");
  var message = TextEditingController();
  File? file;
  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _shareToWhatsApp() async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_image.png';
    await file?.copy(imagePath);
    if (file == null && message.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Enter Any One"),
        duration: Duration(milliseconds: 300),
      ));
    } else {
      try {
        await platform.invokeMethod("shareToWhatsApp", {
          "imagePath": file?.path,
          "text": message.text,
        }).whenComplete(
          () {
            Future.delayed(Duration(seconds: 1),() {
            setState(() {
              file = null;
              message.clear();
            });
          });
          }
        );
        // then((value) {
        //   Future.delayed(Duration(seconds: 10),() {
        //     setState(() {
        //       file = null;
        //       message.clear();
        //     });
        //   },);
        // });
      } on PlatformException catch (e) {
        print("Error: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to share: ${e.message}")));
      }
    }
  }

  Future<void> _shareToInstagram() async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_image.png';
    await file?.copy(imagePath);

    if (file == null && message.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Enter Any One"),
        duration: Duration(milliseconds: 300),
      ));
    } else {
      try {
        await platform.invokeMethod("shareToinsta", {
          "imagePath": file?.path,
          "text": message.text,
        }).whenComplete(
                () {
              Future.delayed(Duration(seconds: 5),() {
                setState(() {
                  file = null;
                  message.clear();
                });
              });
            }
        );
      } on PlatformException catch (e) {
        print("Error: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to share: ${e.message}")));
      }
    }
  }

  Future<void> _shareToface() async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_image.png';
    await file?.copy(imagePath);

    if (file == null && message.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Enter Any One"),
        duration: Duration(milliseconds: 300),
      ));
    } else {
      try {
        await platform.invokeMethod("shareToface", {
          "imagePath": file?.path,
          "text": message.text,
        }).whenComplete(
                () {
              Future.delayed(Duration(seconds: 5),() {
                setState(() {
                  file = null;
                  message.clear();
                });
              });
            }
        );
      } on PlatformException catch (e) {
        print("Error: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to share:Because app Not Installed")));
      }
    }
  }

  Future<void> sendEmailWithAttachment() async {
    if(file!=null && message.text.toString().isNotEmpty) {
      final Email email = Email(
        body: message.text.toString(),
        attachmentPaths: [file!.path], // Attach file
        isHTML: false,
      );
      try {
        await FlutterEmailSender.send(email);
        Future.delayed(Duration(seconds: 0),() {
          setState(() {
            file = null;
            message.clear();
          });
        });
      } catch (e) {
        print("Failed to send email: $e");
      }
    }else  if(file==null && message.text.toString().isNotEmpty) {
      final Email email = Email(
        body: message.text.toString(),
        isHTML: false,
      );
      try {
        await FlutterEmailSender.send(email);
        Future.delayed(Duration(seconds: 0),() {
          setState(() {
            file = null;
            message.clear();
          });
        });
      } catch (e) {
        print("Failed to send email: $e");
      }
    }else  if(file!=null && message.text.toString().isEmpty) {
      final Email email = Email(
        attachmentPaths: [file!.path],
        isHTML: false,
      );
      try {
        await FlutterEmailSender.send(email);
        Future.delayed(Duration(seconds: 0),() {
          setState(() {
            file = null;
            message.clear();
          });
        });
      } catch (e) {
        print("Failed to send email: $e");
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Enter Any One"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK 1"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              child: Container(
                height: 350.h,
                width: 350.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12),
                child: file != null
                    ? Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                    color: Colors.blueGrey, width: 2),
                                image: DecorationImage(
                                    image: FileImage(file!),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Card(
                                  color: Colors.black12,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          file = null;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ))))
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No File Selected!!",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: selectFile,
                                  child: Container(
                                    height: 50,
                                    width: 180,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Lottie.asset("assets/image.json",
                                            fit: BoxFit.cover),
                                        Text(
                                          "Select Image",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: customtext2(
                  label: "Message",
                  hint: "Enter Message Here",
                  controller: message,
                  icon: Icon(Icons.message)),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  _shareToWhatsApp();
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/whatsapp.json", height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "WHATSAPP",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  _shareToInstagram();
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/instagram.json",
                        height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "INSTAGRAM",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  _shareToface();
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/facebook.json", height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "FACEBOOK",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.blue,
              elevation: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  sendEmailWithAttachment();
                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/gmail.json", height: 40, width: 40),
                    SizedBox(height: 5),
                    Text(
                      "     GMAIL     ",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
