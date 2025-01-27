import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class task46 extends StatefulWidget {
  const task46({super.key});

  @override
  State<task46> createState() => _task46State();
}

class _task46State extends State<task46> {
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  String _apiKey =
      "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";

  void _drawRoute() async {
    String start = _startController.text.trim();
    String end = _endController.text.trim();

    if (start.isEmpty || end.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both start and end locations.")),
      );
      return;
    }

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$start&destination=$end&key=$_apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if there are routes in the response
        if (data['routes'].isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No route found for the given locations.")),
          );
          return;
        }

        // Get the polyline
        String polyline = data['routes'][0]['overview_polyline']['points'];

        // Check if polyline is not empty
        if (polyline.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Polyline data is empty.")),
          );
          return;
        }

        // Decode the polyline and add to map
        List<LatLng> points = _decodePolyline(polyline);
        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          );

          // Fit the camera to the bounds of the polyline
          LatLngBounds bounds = _getBounds(points);
          _mapController?.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50),
          );
          _startController.clear();
          _endController.clear();
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to fetch directions. Try again later.")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching directions: $e")),
      );
    }
  }

  LatLngBounds _getBounds(List<LatLng> points) {
    double south =
    points.map((e) => e.latitude).reduce((a, b) => a < b ? a : b);
    double north =
    points.map((e) => e.latitude).reduce((a, b) => a > b ? a : b);
    double west =
    points.map((e) => e.longitude).reduce((a, b) => a < b ? a : b);
    double east =
    points.map((e) => e.longitude).reduce((a, b) => a > b ? a : b);
    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Route Map")),
      body: Column(
        children: [
          Expanded(
            flex: 20,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(20.5937, 78.9629),
                zoom: 5,
              ),
              onMapCreated: (controller) => _mapController = controller,
              polylines: _polylines,
            ),
          ),
          Expanded(
              flex: 2,
              child: GestureDetector(
                  onTap: () {
                    show2();
                  },
                  child: Container(
                    color: Colors.white,
                    child: Center(
                        child: Icon(Icons.arrow_upward_rounded, size: 35)),
                  )))
        ],
      ),
    );
  }
  Future show2() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ENTER DESTINATION"),
          content: Column(
            children: [
              TextField(
                controller: _startController,
                decoration: InputDecoration(
                  labelText: "Start Location",
                  hintText: "Enter Start Location",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _endController,
                keyboardType:TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "End Location",
                  hintText: "Enter End Location",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _drawRoute,
                child: Text("Draw Route"),
              ),
            ],
          ),
          scrollable: true,
        );
      },
    );
  }
}
