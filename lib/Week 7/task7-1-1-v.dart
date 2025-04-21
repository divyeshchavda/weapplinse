import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketcoach/Week%207/gallery2.dart';
import 'package:pocketcoach/Week%207/task7-1.dart';
import 'package:screen_state/screen_state.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'gallery.dart';

class task711v extends StatefulWidget {
  @override
  State<task711v> createState() => _task711vState();
}

class _task711vState extends State<task711v> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  int? inde;
  List<FileSystemEntity> audioFiles = [];
  CameraController? controller;
  bool isRecording = false;
  String _currentOrientation = "Portrait";
  StreamSubscription? _sensorSubscription;
  bool pauserec = false;
  bool iscapture = false;
  int select = 0;
  bool front = false;
  bool flash = false;
  double zoom = 1.0;
  double op = 0.0;
  double angle = -4.7;
  Offset? focus;
  File? img;
  String? errorMessage;
  bool isProcessing = false;
  late FlashMode flashMode;
  List<FileSystemDeleteEvent> image = [];
  Screen _screen = Screen();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    flashMode = FlashMode.off;
    getMusicFiles();
    print(audioFiles);
    init();
    _startOrientationListener();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      print("🔸 App is Inactive (screen off or home button pressed)");
      if(isRecording==true){
        performOnPauseActions();
      }
    } else if (state == AppLifecycleState.paused) {
      print("🔹 App is Paused (background mode)");
    }
  }

  Future<void> performOnPauseActions() async {
    print("Performing onPause actions...");
    _stopRecording();
  }

  void _startOrientationListener() {
    _sensorSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      String newOrientation;
      if (event.x.abs() > event.y.abs()) {
        newOrientation = event.x > 0 ? "Landscape Left" : "Landscape Right";
      } else {
        newOrientation = event.y > 0 ? "Portrait Upside Down" : "Portrait";
      }

      if (newOrientation != _currentOrientation) {
        setState(() {
          _currentOrientation = newOrientation;
          print(_currentOrientation);
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
              path.endsWith(".gif") ||
              path.endsWith(".jpg");
        }).toList();

        audioList.sort((a, b) {
          return b.statSync().modified.compareTo(a.statSync().modified);
        });
        setState(() {
          audioFiles = audioList;
        });
        print(audioFiles);
        setState(() {
          inde = 0;
          print(inde);
        });
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

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
  }

  Future<void> init() async {
    _requestPermissions;
    cameras = await availableCameras();
    initialize();
  }

  void initialize() {
    controller = CameraController(cameras[select], ResolutionPreset.max);
    controller?.initialize().then((value) {
      setState(() {});
    });
  }

  void toggleFlash() {
    if (controller != null) {
      setState(() {
        if (flashMode == FlashMode.off) {
          flashMode = FlashMode.torch;
        } else if (flashMode == FlashMode.torch) {
          flashMode = FlashMode.off;
        }
        controller?.setFlashMode(flashMode);
      });
    }
  }

  void flip() {
    if (front == false) {
      setState(() {
        select = 1;
        front = true;
        controller = CameraController(cameras[select], ResolutionPreset.max);
        controller?.initialize().then((value) {
          setState(() {});
        });
        angle = 4.7;
        flashMode=FlashMode.off;
        controller?.setFlashMode(flashMode);
      });
    } else {
      setState(() {
        select = 0;
        front = false;
        controller = CameraController(cameras[select], ResolutionPreset.max);
        controller?.initialize().then((value) {
          setState(() {});
        });
        angle = -4.7;
        flashMode=FlashMode.off;
        controller?.setFlashMode(flashMode);
        zoom = 1.0;
        controller?.setZoomLevel(zoom);
      });
    }
  }

  Future<void> _startRecording() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    setState(() {
      isProcessing = true;
    });

    try {
      if (_currentOrientation == "Portrait Upside Down") {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath =
            '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mp4';

        await controller!.startVideoRecording();
        setState(() {
          isRecording = true;
          op = 1.0;
        });
      } else if (_currentOrientation == "Landscape Left") {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath = front == false
            ? '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mkv'
            : '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mov';

        await controller!.startVideoRecording();
        setState(() {
          isRecording = true;
          op = 1.0;
        });
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath = front == false
            ? '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mov'
            : '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mkv';

        await controller!.startVideoRecording();
        setState(() {
          isRecording = true;
          op = 1.0;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<void> pause() async {
    if (isRecording == true) {
      if (pauserec == false) {
        if (controller != null && controller!.value.isRecordingVideo) {
          await controller!.pauseVideoRecording();
          setState(() {
            pauserec = true;
          });
        }
      } else {
        if (pauserec) {
          await controller!.resumeVideoRecording();
          setState(() {
            pauserec = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Recording Not Started"),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  Future<void> _stopRecording() async {
    if (!controller!.value.isRecordingVideo) {
      return;
    }
    setState(() {
      isProcessing = true; // Disable button while processing
    });

    try {
      if (_currentOrientation == "Portrait Upside Down") {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath =
            '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mp4';
        final videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
          pauserec = false;
          op = 0.0;
        });
        videoFile.saveTo(custompath);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Video Saved'),
          duration: Duration(milliseconds: 400),
        ));
        print({videoFile.path});
      } else if (_currentOrientation == "Landscape Left") {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath = front == false
            ? '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mkv'
            : '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mov';

        final videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
          pauserec = false;
          op = 0.0;
        });
        videoFile.saveTo(custompath);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Video Saved'),
          duration: Duration(milliseconds: 400),
        ));
        print({videoFile.path});
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        final custompath = front == false
            ? '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mov'
            : '/storage/emulated/0/Weappliance/${DateTime.now().millisecondsSinceEpoch}.mkv';

        final videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
          pauserec = false;
          op = 0.0;
        });
        videoFile.saveTo(custompath);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Video Saved'),
          duration: Duration(milliseconds: 400),
        ));
        print({videoFile.path});
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void onZoomChanged(double value) {
    setState(() {
      zoom = value;
    });
    controller?.setZoomLevel(zoom); // Set zoom level
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    _sensorSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller!.value.isRecordingVideo == false) {
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('First Stop Recording'),
            duration: Duration(milliseconds: 400),
          ));
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            front == false ? Text("${zoom.toStringAsFixed(1)}x") : SizedBox(),
            front == false
                ? Slider(
                    activeColor: Colors.blue,
                    value: zoom,
                    min: 1.0,
                    max: 4.0,
                    divisions: 30,
                    label: "${zoom.toStringAsFixed(1)}x",
                    onChanged: onZoomChanged,
                  )
                : SizedBox(),
          ],
          title: Text("Camera"),
        ),
        body: Column(
          children: [
            Container(
              height: 620,
              width: 360,
              color: Colors.black,
              child: Stack(
                children: [
                  if (controller != null && controller!.value.isInitialized)
                    front == true
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..scale(-1.0, 1.0, 1.0),
                            child: Center(
                              child: CameraPreview(controller!),
                            ),
                          )
                        : Center(
                            child: CameraPreview(controller!),
                          )
                  else
                    Center(
                      child: CircularProgressIndicator(),
                    ), // Show loading indicator
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 75,
              width: 360,
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity:
                        controller?.value.isRecordingVideo == false ? 1.0 : 0.0,
                    child: Card(
                      color: Colors.white12,
                      child: IconButton(
                        onPressed: () {
                          controller?.value.isRecordingVideo == false
                              ? flip()
                              : ();
                        },
                        icon: Icon(
                          Icons.flip_camera_android_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity: op,
                    child: Card(
                      color: Colors.white12,
                      child: IconButton(
                        onPressed: pause,
                        icon: Icon(
                          pauserec == false ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    color: Colors.white12,
                    child: IconButton(
                      color: isRecording ? Colors.red : Colors.blue,
                      onPressed: (isProcessing || (isRecording && pauserec))
                          ? null
                          : (isRecording ? _stopRecording : _startRecording),
                      icon: Icon(isRecording ? Icons.stop : Icons.videocam,
                          size: 50),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  front == false
                      ? Card(
                          color: Colors.white12,
                          child: IconButton(
                            onPressed: toggleFlash,
                            icon: Icon(
                              flashMode == FlashMode.off
                                  ? Icons.flash_off
                                  : Icons.flash_on,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 65,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      zoom = 1.0;
                      controller?.setZoomLevel(zoom);
                      controller!.value.isRecordingVideo == false
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => gallery2(),
                              ))
                          : ();
                    },
                    child: audioFiles[inde!].path.endsWith(".png")
                        ? Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white12,
                                image: DecorationImage(
                                    image: FileImage(File(
                                        audioFiles[inde!].path.toString())),
                                    fit: BoxFit.cover)),
                          )
                        : audioFiles[inde!].path.endsWith(".jpeg")
                            ? Transform.rotate(
                                angle: 4.7,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white12,
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              audioFiles[inde!]
                                                  .path
                                                  .toString())),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            : Transform.rotate(
                                angle: -4.7,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white12,
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              audioFiles[inde!]
                                                  .path
                                                  .toString())),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
