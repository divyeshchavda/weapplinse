import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../Week 2/helper2.dart';

class task62 extends StatefulWidget {
  const task62({super.key});

  @override
  State<task62> createState() => _task62State();
}

class _task62State extends State<task62> {
  File? file;
  var message=TextEditingController();
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }
  Future<void> share() async {
    final directory = await getTemporaryDirectory();

    if (file == null && message.text.isNotEmpty) {
      await Share.share(message.text);
      setState(() {
        message.clear();
        file=null;
      });
    } else if (file != null) {

      String? path = file?.path;

      await Share.shareXFiles(
        [XFile(path!)],
        text: message.text,
        sharePositionOrigin: Rect.fromLTWH(0, 0, 1, 1),
      );
      setState(() {
        message.clear();
        file=null;
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Any One"),duration: Duration(milliseconds: 400),));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK 2"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Card(
              elevation: 10,
              child: Container(
                height: 350.h,
                width: 350.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12
                ),
                child: file != null?Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.blueGrey, width: 2),
                          image: DecorationImage(image: FileImage(file!),fit: BoxFit.cover)
                      ),
                    ),
                    Align(alignment:Alignment.topRight,child: Card(color:Colors.black12,child: IconButton(onPressed: (){
                      setState(() {
                        file=null;
                      });
                    }, icon: Icon(Icons.cancel,color: Colors.red,))))
                  ],
                ):Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No File Selected!!",style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
                      SizedBox(height: 10,),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Lottie.asset("assets/image.json",fit: BoxFit.cover),
                                  Text(
                                    "Select Image",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
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
              child: customtext2(label: "Message", hint: "Enter Message Here", controller: message, icon: Icon(Icons.message)),
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
                  share();

                },
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Lottie.asset("assets/share.json", height: 30, width: 30),
                    SizedBox(height: 5),
                    Text(
                      "SHARE",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
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
