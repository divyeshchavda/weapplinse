import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketcoach/Week%207/photo.dart';
import 'package:pocketcoach/Week%207/v1.dart';


import '../Week 5/video.dart';


class gallery extends StatefulWidget {
  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  List<FileSystemEntity> audioFiles = [];
  List<FileSystemEntity> image = [];
  List<FileSystemEntity> videoFiles = [];
  List<FileSystemEntity> video = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioPath;
  bool _isPlaying = false;
  bool _isStopped = true;
  double _currentPosition = 0.0;
  double _volume = 1.0;
  Duration _duration = Duration.zero;
  Duration _currentDuration = Duration.zero;

  String _errorMessage = ""; // Error message for out of range validation



  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _status = "Permission not requested";

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.isGranted ||
        await Permission.manageExternalStorage.isGranted ||
        await Permission.mediaLibrary.isGranted) {
      setState(() => _status = "Permission already granted");
      return;
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.audio, // For accessing audio files
      Permission.photos, // For images (optional)
      Permission.videos, // For video files (optional)
    ].request();

    if (statuses[Permission.audio]!.isGranted) {
      setState(() => _status = "Permission Granted");
    } else {
      setState(
          () => _status = "Permission Denied Please Accept It in Settings");
    }
  }

  @override
  void initState() {
    super.initState();
    print(audioFiles);
    getMusicFiles();
    getvideoFiles();
    requestStoragePermission();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _currentDuration = p;
        _currentPosition = p.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  Future<void> getMusicFiles() async {
    var status = await Permission.audio.status;
    if (status.isDenied) {
      status = await Permission.audio.request();
    }
    if (status.isGranted) {
      Directory musicDir = Directory("/storage/emulated/0/Weappliance/");
      if (musicDir.existsSync()) {
        List<FileSystemEntity> files = musicDir.listSync(recursive: false);
        List<FileSystemEntity> audioList = files.where((file) {
          String path = file.path.toLowerCase();
          return path.endsWith(".jpeg") ||
              path.endsWith(".png") ||
              path.endsWith(".gif")||
              path.endsWith(".jpg");
        }).toList();
        audioList.sort((a, b) {
          return b.statSync().modified.compareTo(a.statSync().modified);
        });
        setState(() {
          audioFiles = audioList;
          image=audioFiles.toList();
        });
        print(audioFiles);

      } else {
        print("Image folder not found!");
      }
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Permission permanently denied. Enable it in app settings.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Storage permission denied.')),
      );
    }
  }
  Future<void> getvideoFiles() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }
    if (status.isGranted) {
      Directory musicDir = Directory("/storage/emulated/0/Weappliance/");
      if (musicDir.existsSync()) {
        List<FileSystemEntity> files = musicDir.listSync(recursive: false);
        List<FileSystemEntity> audioList = files.where((file) {
          String path = file.path.toLowerCase();
          return path.endsWith(".mp4") ||
              path.endsWith(".avi") ||
              path.endsWith(".mov")||path.endsWith(".mkv");
        }).toList();
        audioList.sort((a, b) {
          return b.statSync().modified.compareTo(a.statSync().modified);
        });
        setState(() {
          video = audioList;
        });
        print(videoFiles);
      } else {
        print("Image folder not found!");
      }
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Permission permanently denied. Enable it in app settings.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Storage permission denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.image),
                    text: "Images",
                  ),
                  Tab(
                    icon: Icon(Icons.video_camera_back_rounded),
                    text: "Videos",
                  ),

                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: image.isEmpty
                          ? Center(child: Text("No Images files found"))
                          : GridView.builder(
                              itemCount: image.length,
                              itemBuilder: (context, index) {
                                return image[index].path.endsWith(".png")?GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => photo(audioFiles: image, img: image[index].path.toString(),),));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  image[index]
                                                      .path
                                                      .toString())),fit: BoxFit.cover)),
                                    ),
                                  ),
                                ):image[index].path.endsWith(".jpeg")?GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => photo(audioFiles: image, img: image[index].path.toString(),),));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  image[index]
                                                      .path
                                                      .toString())),fit: BoxFit.cover)),
                                    ),
                                  ),
                                ):GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => photo(audioFiles: image, img: image[index].path.toString(),),));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Transform.rotate(
                                      angle: -4.7,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: FileImage(File(
                                                    image[index]
                                                        .path
                                                        .toString())),fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                            ),
                    ),
                    Center(
                      child: video.isEmpty
                          ? Center(child: Text("No video files found"))
                          : ListView.builder(
                        itemCount: video.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              child: ListTile(
                                title: Text(video[index].path.split('/').last),
                                leading: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Lottie.asset("assets/video.json")
                                ),
                                subtitle: Text("Video"),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => v1(path: video[index].path,videol: video, name: video[index].path.split('/').last,),));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

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
