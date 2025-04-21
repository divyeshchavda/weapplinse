import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class method extends StatefulWidget {
  const method({super.key});

  @override
  State<method> createState() => _methodState();
}

class _methodState extends State<method> {
  static const batteryChannel =
      MethodChannel('com.example.methodchannel/battery');

  String _batteryLevel = 'Unknown';

  Future<void> getBatteryLevel() async {
    print("method");
    try {
      final int result = await batteryChannel.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = 'Battery Level: $result%';
      });
    } catch (e) {
      _batteryLevel = "Error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Battery & Sharing",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _batteryLevel,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                ),
                onPressed: getBatteryLevel,
                child: Text(
                  "Get Battery Level",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
