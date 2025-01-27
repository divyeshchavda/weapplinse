import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class task43 extends StatefulWidget {
  const task43({super.key});

  @override
  State<task43> createState() => _task43State();
}

class _task43State extends State<task43> {
  final k = GlobalKey<FormState>();
  var reciever = TextEditingController();
  var subject = TextEditingController();
  var message = TextEditingController();
  File? file;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }


  Future<void> sendmail(String receiver, String subject, String message) async {
    final String email = 'dmchavda.weapplinse@gmail.com';
    final String pass = 'nzwkzkbrowldqemx';
    final smtpserver = gmail(email, pass);
    var k=GlobalKey<FormState>();

    final mess = Message()
      ..from = Address(email, "DEMO")
      ..recipients.add(receiver)
      ..subject = subject
      ..text = message;

    if (file != null) {
      mess.attachments.add(FileAttachment(file!));
    }

    try {
      final sendReport = await send(mess, smtpserver);
      print('Email sent: ${sendReport.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email sent successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 3(Send Email)"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: k,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Send Mail",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.10,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: reciever,
                        validator: (a) {
                          if (a == null || a.isEmpty) {
                            return "Plz Enter Email Its Required";
                          }
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                              .hasMatch(a)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        maxLength: 35,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Receiver Email',
                          hintText: 'Enter your Receiver Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (a) {
                          if (a == null || a.isEmpty) {
                            return "Plz Enter Subject Its Required";
                          }
                          return null;
                        },
                        controller: subject,
                        maxLength: 35,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Subject',
                          hintText: 'Enter your Subject',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.subject),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (a) {
                          if (a == null || a.isEmpty) {
                            return "Plz Enter Message Its Required";
                          }
                          return null;
                        },
                        controller: message,
                        maxLines: 5,
                        maxLength: 200,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Message',
                          hintText: 'Enter your Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.message),
                        )),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: selectFile,
                      child: Text(
                        "Attachment",
                        style: TextStyle(color: Colors.white),
                      )),
                  // File display container
                  if (file != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.blueGrey, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected File:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              file!.path.split('/').last, // Show file name
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                            // Optional: Display an image if the file is an image
                            if (file!.path.endsWith('.png') ||
                                file!.path.endsWith('.jpg') ||
                                file!.path.endsWith('.jpeg'))
                              Center(
                                child: Image.file(
                                  file!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            // Display an icon for other file types
                            if (!(file!.path.endsWith('.png') ||
                                file!.path.endsWith('.jpg') ||
                                file!.path.endsWith('.jpeg')))
                              Icon(
                                Icons.attach_file,
                                size: 40,
                                color: Colors.grey[700],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {
                        if(k.currentState?.validate() ?? false){
                          sendmail(reciever.text, subject.text, message.text);
                          setState(() {
                            reciever.clear();
                            subject.clear();
                            message.clear();
                            file = null;
                          });
                        }
                      },
                      child: Text("SEND MAIL", style: TextStyle(color: Colors.white)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
