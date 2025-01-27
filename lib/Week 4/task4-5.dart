import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class task45 extends StatefulWidget {
  @override
  _task45State createState() => _task45State();
}

class _task45State extends State<task45> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendSms(String phoneNumber, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );

    // Check SMS permission status
    var smsPermissionStatus = await Permission.sms.status;

    if (smsPermissionStatus.isDenied || smsPermissionStatus.isRestricted) {
      // Request SMS permission
      smsPermissionStatus = await Permission.sms.request();
    }

    if (smsPermissionStatus.isGranted) {
      // If permission is granted, try launching the SMS URL
        try {
          await launchUrl(smsUri);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error sending SMS: $e')),
          );
        }
    } else if (smsPermissionStatus.isPermanentlyDenied) {
      // Handle permanently denied permission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'SMS permission is permanently denied. Please enable it in app settings.'),
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
        const SnackBar(content: Text('SMS permission denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 5(Send SMS)'),
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
            child: Column(
              children: [
                Text("SEND SMS",style: TextStyle(
                    fontSize:
                    MediaQuery.of(context).size.width *
                        0.10,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),),
                const SizedBox(height: 30),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(filled: true, fillColor: Colors.white,
                    labelText: 'Enter phone number',
                    hintText: 'Enter phone number',
                    border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.call)
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _messageController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  maxLength: 100,
                  decoration: const InputDecoration(filled: true, fillColor: Colors.white,
                    labelText: 'Enter your message',
                    hintText: 'Enter your message',
                    border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.messenger_sharp)
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    final phoneNumber = _phoneController.text.trim();
                    final message = _messageController.text.trim();

                    if (phoneNumber.isNotEmpty && message.isNotEmpty) {
                      _sendSms(phoneNumber, message);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields.')),
                      );
                    }
                    _phoneController.clear();
                    _messageController.clear();
                  },
                  child: const Text('Send SMS',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
