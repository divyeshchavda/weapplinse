import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class task41 extends StatefulWidget {
  const task41({super.key});

  @override
  State<task41> createState() => _task41State();
}

class _task41State extends State<task41> {
  List url = [
    'https://static.vecteezy.com/system/resources/previews/023/808/287/non_2x/lion-on-fire-for-background-generative-ai-photo.jpg',
    'https://4kwallpapers.com/images/wallpapers/lion-mane-ai-art-2048x2048-14199.jpg',
    'https://4kwallpapers.com/images/wallpapers/lion-african-black-background-5k-2048x2048-1528.jpg',
    'https://images.unsplash.com/photo-1629812456605-4a044aa38fbc?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGlvbiUyMHdhbGxwYXBlcnxlbnwwfHwwfHx8MA%3D%3D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUDpzBk-XjDZbbvreS_eXtwGHZ2ep2HkB3Ug&s',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEEK 4"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
        itemCount: url.length,
        itemBuilder: (context, index) {
          final img = url[index];
          return GestureDetector(
            onTap: () async {
              var response = await http.get(Uri.parse(img));
              Directory? externalStorageDirectory =
                  await getExternalStorageDirectory();
              print(externalStorageDirectory);
              File file = new File(
                  path.join(externalStorageDirectory!.path, path.basename(img)));
              await file.writeAsBytes(response.bodyBytes);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Image saved Successfully!"),
                    content: Image.file(file),
                  )
              );
            },
            child: CachedNetworkImage(
              imageUrl: img,
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
          );
        },
      ),
    );
  }
}
