import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as access;
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'gallery.dart';


class ImageProcessingParams {
  final Uint8List imageBytes;
  final double angle;

  ImageProcessingParams(this.imageBytes, this.angle);
}

// Top-level function to process the image in a background isolate
Uint8List processImage(ImageProcessingParams params) {
  access.Image originalImage = access.decodeImage(params.imageBytes)!;
  access.Image rotatedImage = access.copyRotate(originalImage, angle: params.angle);
  return access.encodeJpg(rotatedImage);
}

// Helper function to determine rotation angle
double getRotationAngle(String orientation, bool isFront) {
  if (orientation == "Portrait Upside Down") {
    return 0;
  } else if (orientation == "Landscape Left") {
    return isFront ? 90 : 270;
  } else if (orientation == "Landscape Right") {
    return isFront ? 270 : 90;
  } else { // "Portrait"
    return 180;
  }
}

class task711 extends StatefulWidget {

  @override
  State<task711> createState() => _task711State();
}

class _task711State extends State<task711> {
  List<FileSystemEntity> audioFiles = [];
  List<CameraDescription> cameras=[];
  CameraController? controller;
  bool isRecording = false;
  String _currentOrientation = "Portrait";
  StreamSubscription? _sensorSubscription;
  int count =0;
  bool iscapture=false;
  bool land=false;
  int select=0;
  bool front=false;
  bool flash=false;
  bool ton=false;
  double zoom=1.0;
  double angle=-4.7;
  Offset? focus;
  File? img;
  late FlashMode flashMode;
  List<FileSystemDeleteEvent> image=[];
  int? inde;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flashMode=FlashMode.off;
    getMusicFiles();
    print(audioFiles);
    init();
    _startOrientationListener();
  }
  void _startOrientationListener() {
    _sensorSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
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
              path.endsWith(".gif")||
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
          inde=0;
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
    cameras=await availableCameras();
    initialize();
  }
  void initialize(){
    controller=CameraController(cameras[select], ResolutionPreset.veryHigh);
    controller?.initialize().then((value){
      setState(() {

      });
    });
  }
  void toggleFlash() {
    if (controller != null) {
      setState(() {
        if (flashMode == FlashMode.off) {
          flashMode = FlashMode.auto;
        } else if (flashMode == FlashMode.auto) {
          flashMode = FlashMode.always;
        } else if (flashMode == FlashMode.always){
          flashMode = FlashMode.torch;
        }else{
          flashMode = FlashMode.off;
        }
        controller?.setFlashMode(flashMode);
      });
    }
  }
  void flip (){
    if(front==false){
      setState(() {
        select=1;
        front=true;
        controller=CameraController(cameras[select], ResolutionPreset.veryHigh);
        controller?.initialize().then((value){
          setState(() {

          });
        });
        angle=4.7;
        controller?.setFlashMode(flashMode);
      });
    }
    else{
      setState(() {
        select=0;
        front=false;
        controller=CameraController(cameras[select], ResolutionPreset.veryHigh);
        controller?.initialize().then((value){
          setState(() {

          });
        });
        angle=-4.7;
        flashMode=FlashMode.off;
        controller?.setFlashMode(flashMode);
        zoom=1.0;
        controller?.setZoomLevel(zoom);
      });
    }
  }
  Future<void> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      print("Camera not initialized");
      return;
    }

    try {
      // Step 1: Capture Image
      XFile image = await controller!.takePicture();

      // Step 2: Define Custom Path
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final customPath = '/storage/emulated/0/Weappliance/$fileName';

      // Step 3: Fix Orientation Before Saving
      File correctedImage = await fixImageOrientation(File(image.path),_currentOrientation);

      // Step 4: Save to Custom Path
      await correctedImage.copy(customPath);

      print("✅ Image saved to: $customPath");

      // Step 5: Show Confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Captured and saved successfully")),
      );
      setState(() {
        getMusicFiles();
      });

    } catch (e) {
      print("❌ Error capturing image: $e");
    }
  }
  Future<File> fixImageOrientation(File file,String Orientation) async {
    // Read the image bytes
    Uint8List bytes = await file.readAsBytes();

    // Read Exif metadata from the image
    final Map<String, IfdTag> exifData = await readExifFromBytes(bytes);

    // Extract orientation value
    int orientation = exifData['Image Orientation']?.values.firstAsInt() ?? 1;

    // Decode the image using image package
    access.Image? originalImage = access.decodeImage(bytes);
    if (originalImage == null) return file;

    // Rotate the image based on the orientation tag
    access.Image rotatedImage;
    switch (Orientation) {
      case "Portrait Upside Down": // 180 degrees
        rotatedImage = access.copyRotate(originalImage,  angle: 0,);
        break;
      case "Landscape Left": // 90 degrees
        rotatedImage = access.copyRotate(originalImage, angle: front ? 90 : 270, );
        break;
      case "Landscape Right": // 270 degrees
        rotatedImage = access.copyRotate(originalImage, angle: front ? 270 : 90, );
        break;
      case "Portrait": // 270 degrees
        rotatedImage = access.copyRotate(originalImage, angle: 180, );
        break;
      default: // No rotation needed
        return file;
    }

    // Save the fixed image
    File newFile = File(file.path)..writeAsBytesSync(access.encodeJpg(rotatedImage));
    return newFile;
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [  front==false?Text("${zoom.toStringAsFixed(1)}x",):SizedBox(),
    front==false?Slider(activeColor: Colors.blue,
            value: zoom,
            min: 1.0,
            max: 4.0,
            divisions: 30,
            label: "${zoom.toStringAsFixed(1)}x",
            onChanged: onZoomChanged,
          ):SizedBox(),],
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
                 front==true?Transform(
                   alignment: Alignment.center,
                   transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                   child: Center(
                      child: CameraPreview(controller!),
                    ),
                 ): Center(
        child: CameraPreview(controller!),
    )
                else
                  Center(child: CircularProgressIndicator()), // Show loading indicator
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 75,
            width: 360,
            child: Row(
              children: [
                SizedBox(width: 5,),
                Card(
                  color: Colors.white12,
                  child: IconButton(
                    onPressed: () {
                      flip();
                    },
                    icon: Icon(Icons.flip_camera_android_rounded,size: 40,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 5,),
                SizedBox(width: 65,),
                SizedBox(width: 10,),
                Card(
                  color: Colors.white12,

                  child: IconButton(onPressed: (){
                    takePicture();
                  }, icon: Icon(Icons.camera,color: Colors.white,size: 40,))
                ),
                SizedBox(width: 10,),
                front==false?Card(
                  color: Colors.white12,
                  child: IconButton(
                    onPressed: toggleFlash,
                    icon: Icon(
                      flashMode == FlashMode.off
                          ? Icons.flash_off
                          : flashMode == FlashMode.auto
                          ? Icons.flash_auto
                          :flashMode == FlashMode.always
                      ?Icons.flash_on:Icons.flashlight_on_rounded,
                      color: Colors.white,size: 40,),
                  ),
                ):SizedBox(width: 65,),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      zoom=1.0;
                      controller?.setZoomLevel(zoom);
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => gallery(),));
                  },
                  child: audioFiles[inde!].path.endsWith(".png")?Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white12,
                        image: DecorationImage(image: FileImage(File(audioFiles[inde!].path.toString())),fit: BoxFit.cover)
                    ),
                  ):audioFiles[inde!].path.endsWith(".jpeg")?Transform.rotate(
                    angle: 4.7,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white12,
                          image: DecorationImage(image: FileImage(File(audioFiles[inde!].path.toString())),fit: BoxFit.cover)
                      ),
                    ),
                  ):Transform.rotate(
                    angle: -4.7,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white12,
                          image: DecorationImage(image: audioFiles.isNotEmpty?FileImage(File(audioFiles[inde!].path.toString())):AssetImage("assets/2.png"),fit: BoxFit.cover)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


