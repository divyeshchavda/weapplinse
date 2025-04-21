import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketcoach/Week%205/video.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Week 6/task6-3-2/video.dart';


class task52 extends StatefulWidget {
  @override
  _task52State createState() => _task52State();
}

class _task52State extends State<task52> {
  List<FileSystemEntity> audioFiles = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioPath;
  bool _isPlaying = false;
  bool _isStopped = true;
  double _currentPosition = 0.0;
  double _volume = 1.0;
  Duration _duration = Duration.zero;
  Duration _currentDuration = Duration.zero;

  String _errorMessage = "";

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
      setState(() => _status = "Permission Denied");
    }
  }
  @override
  void initState() {
    super.initState();
    getMusicFiles();
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
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
    }
    if (status.isGranted) {
      Directory musicDir = Directory("/storage/emulated/0/Video/");
      if (musicDir.existsSync()) {
        List<FileSystemEntity> files = musicDir.listSync(recursive: false);
        List<FileSystemEntity> audioList = files.where((file) {
          String path = file.path.toLowerCase();
          return path.endsWith(".mp4") || path.endsWith(".MOV") || path.endsWith(".mkv");
        }).toList();

        setState(() {
          audioFiles = audioList;
        });
        print(audioFiles);
      } else {
        print("Video folder not found!");
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
    return Scaffold(
      appBar: AppBar(title: Text("Video Files")),
      body: audioFiles.isEmpty
          ? Center(child: Text("No Video files found"))
          : ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: ListTile(
                title: Text(audioFiles[index].path.split('/').last.length<=25?audioFiles[index].path.split('/').last:"${audioFiles[index].path.split('/').last.substring(0,25)}...mp4"),
                leading: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Lottie.asset("assets/video.json")
                ),
                subtitle: Text("Video"),
                onTap: (){
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(scrollable: true,
                      title: Text("Choose Player"),
                      content: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var status = await Permission.manageExternalStorage.request();
                              if (status.isGranted) {
                                Navigator.pop(context);
                                OpenFile.open(audioFiles[index].path);
                              } else {
                                print("Permission denied");
                              }
                            },
                            child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Default Video Player", style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color: Color(0xFF3A2764)),)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              print(audioFiles[index].path.toString());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => vide(path: audioFiles[index].path, videol: audioFiles, name: audioFiles[index].path.split('/').last,),));
                            },
                            child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Custom Video Player", style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color: Color(0xFF3A2764)),)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

