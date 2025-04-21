import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class StoragePermissionScreen extends StatefulWidget {
  @override
  _StoragePermissionScreenState createState() => _StoragePermissionScreenState();
}

class _StoragePermissionScreenState extends State<StoragePermissionScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Storage Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: requestStoragePermission,
              child: Text("Request Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
