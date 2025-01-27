import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
class task44 extends StatefulWidget {
  @override
  _task44State createState() => _task44State();
}

class _task44State extends State<task44> {
  var k = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _requestPermissionAndCall(String phoneNumber) async {
    var status = await Permission.phone.status;

    if (status.isDenied) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      await _makePhoneCall(phoneNumber);
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
        const SnackBar(content: Text('Phone call permission denied.')),
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4(Direct Call)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(decoration: BoxDecoration(
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
                  Center(
                    child: Text("Direct Call",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.10,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(filled: true, fillColor: Colors.white,
                        labelText: 'Enter phone number',
                        hintText: 'Enter phone number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.call)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      final phoneNumber = _phoneController.text.trim();
                      if (phoneNumber.isNotEmpty) {
                        _requestPermissionAndCall(phoneNumber);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter a phone number')),
                        );
                      }
                      _phoneController.clear();
                    },
                    child: const Text('Call Now',style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
