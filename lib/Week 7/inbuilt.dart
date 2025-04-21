import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

import 'package:lottie/lottie.dart';

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  Future<void> _pickvideo(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(_image!.path.toString());
        print(_image);
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _image=null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In Built '),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12
                    ),
                    child: _image != null?Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(_image!.path.endsWith(".mp4")){
                              OpenFile.open(_image!.path.toString());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.blueGrey, width: 2),
                                image: DecorationImage(image: _image!.path.endsWith(".mp4")?AssetImage("assets/img_8.png"):FileImage(_image!),fit: BoxFit.cover)
                            ),
                          ),
                        ),
                        Align(alignment:Alignment.topRight,child: Card(color:Colors.black12,child: IconButton(onPressed: (){
                          setState(() {
                            _image=null;
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Lottie.asset("assets/up.json",height: 40,width: 40),
                      SizedBox(height: 5,),
                      Text('Open Gallery' ,style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
              ),
                onPressed: () => _pickImage(ImageSource.camera),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Lottie.asset("assets/C.json",height: 40,width: 40),
                    SizedBox(height: 5,),
                    Text('Take Picture' ,style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
              ),
                onPressed: () => _pickvideo(ImageSource.camera),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Lottie.asset("assets/v.json",height: 50,width: 50),
                    SizedBox(height: 5,),
                    Text('Take Video' ,style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImagePickerExample(),
  ));
}


