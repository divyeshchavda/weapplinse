import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main(){
  runApp(MaterialApp(home: WhatsAppSharePage(),));
}
class WhatsAppSharePage extends StatefulWidget {
  @override
  _WhatsAppSharePageState createState() => _WhatsAppSharePageState();
}

class _WhatsAppSharePageState extends State<WhatsAppSharePage> {
  TextEditingController _textController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _shareContent() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select an image first.")));
      return;
    }

    // Copy the image to a temporary location.
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_image.png';
    await _imageFile!.copy(imagePath);

    // Share using share_plus
    await Share.shareXFiles(
      [XFile(imagePath)],
      text: _textController.text,
      sharePositionOrigin: Rect.fromLTWH(0, 0, 1, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Content")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : Text("No Image Selected"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: "Enter custom text"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareContent,
              child: Text("Share Content"),
            ),
          ],
        ),
      ),
    );
  }
}
