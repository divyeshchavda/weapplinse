import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class task422 extends StatefulWidget {
  const task422({Key? key}) : super(key: key);

  @override
  _task422State createState() => _task422State();
}

class _task422State extends State<task422> {
  final TextEditingController _controller = TextEditingController();

  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  LatLng? _selectedLocation; // To store selected location coordinates
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = Random().nextInt(100000000).toString();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I"; // Replace with your API key
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  void _getPlaceDetails(String placeId) async {
    const String PLACES_API_KEY = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I"; // Replace with your API key
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY';

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        var result = json.decode(response.body)['result'];
        double lat = result['geometry']['location']['lat'];
        double lng = result['geometry']['location']['lng'];

        setState(() {
          _selectedLocation = LatLng(lat, lng);
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(_selectedLocation!),
          );
        });
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Search Location & Display on Map'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Search your location here",
              prefixIcon: const Icon(Icons.map),
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  _controller.clear();
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_placeList[index]["description"]),
                        onTap: () {
                          String placeId = _placeList[index]["place_id"];
                          _getPlaceDetails(placeId);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation ?? const LatLng(20.5937, 78.9629), // Default to India
                      zoom: 13,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: _selectedLocation != null
                        ? {
                      Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: _selectedLocation!,
                      ),
                    }
                        : {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
