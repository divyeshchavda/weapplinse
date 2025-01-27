import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class task421 extends StatefulWidget {
  @override
  _task421State createState() => _task421State();
}

class _task421State extends State<task421> {
  late GoogleMapController mapController;
  var a="";
  LatLng? _currentPosition;
  LatLng? _destinationPosition;

  final TextEditingController _currentAddressController =
  TextEditingController();
  final TextEditingController _destinationAddressController =
  TextEditingController();

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  List<String> _currentAddressSuggestions = [];
  List<String> _destinationAddressSuggestions = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }


  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw "Location services are disabled. Please enable them.";
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw "Location permission denied.";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw "Location permissions are permanently denied.";
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 13));
      await _getAddressFromLatLng(position.latitude, position.longitude);

      setState(() {});
    } catch (e) {
      setState(() {
        _currentAddressController.text = "Error fetching location: $e";
      });
    }
  }


  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["results"] != null && data["results"].isNotEmpty) {
          setState(() {
            _currentAddressController.text =
            data["results"][0]["formatted_address"];
          });
        } else {
          setState(() {
            _currentAddressController.text = "Unable to fetch place name.";
          });
        }
      } else {
        setState(() {
          _currentAddressController.text =
          "Failed to fetch address: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _currentAddressController.text = "Error fetching address: $e";
      });
    }
  }


  Future<void> _getCurrentAddressSuggestions(String query) async {
    const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["predictions"] != null) {
          setState(() {
            _currentAddressSuggestions = List<String>.from(
                data["predictions"].map((x) => x["description"]));
          });
        }
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
    }
  }


  Future<void> _getDestinationAddressSuggestions(String query) async {
    const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["predictions"] != null) {
          setState(() {
            _destinationAddressSuggestions = List<String>.from(
                data["predictions"].map((x) => x["description"]));
          });
        }
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
    }
  }


  Future<void> _getCoordinatesFromAddress(
      String address, bool isDestination) async {
    const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["results"] != null && data["results"].isNotEmpty) {
          final location = data["results"][0]["geometry"]["location"];
          final latLng = LatLng(location["lat"], location["lng"]);
          setState(() {
            if (isDestination) {
              _destinationPosition = latLng;
              _drawPolyline();
            } else {
              _currentPosition = latLng;
              _drawPolyline();
            }
          });
          mapController.animateCamera(CameraUpdate.newLatLng(latLng));
        }
      }
    } catch (e) {
      print(e);
    }
  }


  void _drawPolyline() {
    if (_currentPosition != null && _destinationPosition != null) {
      _getDirections();
    }
  }


  Future<void> _getDirections() async {
    if (_currentPosition == null || _destinationPosition == null) return;

    const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${_destinationPosition!.latitude},${_destinationPosition!.longitude}&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["routes"].isNotEmpty) {

          List<LatLng> polylinePoints = [];
          for (var leg in data["routes"][0]["legs"]) {
            for (var step in leg["steps"]) {
              final points = _decodePolyline(step["polyline"]["points"]);
              polylinePoints.addAll(points);
            }
          }


          final polyline = Polyline(
            polylineId: PolylineId("route"),
            visible: true,
            points: polylinePoints,
            color: Colors.blue,
            width: 4,
          );

          setState(() {
            _polylines.add(polyline);
          });
        }
      } else {
        print("Error fetching directions: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching directions: $e");
    }
  }


  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int shift = 0;
      int result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      polylinePoints.add(LatLng((lat / 1E5), (lng / 1E5)));
    }

    return polylinePoints;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  void _onTap(LatLng position) async {
    setState(() {
      _destinationPosition = position;
      _destinationAddressController.text = "Loading..."; // Temporary text
    });

    // Fetch the address for the tapped location and update the destination field
    try {
      const String apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["results"] != null && data["results"].isNotEmpty) {
          setState(() {
            _destinationAddressController.text =
            data["results"][0]["formatted_address"];
          });
        } else {
          setState(() {
            _destinationAddressController.text = "Unable to fetch address.";
          });
        }
      } else {
        setState(() {
          _destinationAddressController.text =
          "Error fetching address: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _destinationAddressController.text = "Error fetching address: $e";
      });
    }


    _drawPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? LatLng(21.1702, 72.8311),
              zoom: 14.0,
            ),
            markers: {
              if (_currentPosition != null)
                Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: _currentPosition!,
                    infoWindow: InfoWindow(
                        title: "LatLng:(${_currentPosition?.latitude.toString().substring(0,8)} , ${_currentPosition?.longitude.toString().substring(0,8)})"
                    )
                ),
              if (_destinationPosition != null)
                Marker(
                    markerId: const MarkerId("destinationLocation"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                    position: _destinationPosition!,
                    infoWindow: InfoWindow(
                        title: "LatLng:(${_destinationPosition?.latitude.toString().substring(0,8)} , ${_destinationPosition?.longitude.toString().substring(0,8)})"
                    )
                ),
            },
            polylines: _polylines,

            onTap: _onTap,
          ),
          Positioned(
            top: 40.0,
            left: 15.0,
            right: 15.0,
            child: Column(
              children: [

                TextField(
                  controller: _currentAddressController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _currentPosition = null;
                        _currentAddressSuggestions = [];
                      });
                    } else {
                      _getCurrentAddressSuggestions(value);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Your location",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _currentAddressController.clear();
                          _currentPosition = null;
                          _currentAddressSuggestions = [];
                          _polylines.clear();
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0), // Reduced padding
                  ),
                ),
                if (_currentAddressSuggestions.isNotEmpty)
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4.0),
                      ],
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero, // Remove padding from the ListView
                      itemCount: _currentAddressSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _currentAddressSuggestions[index],
                            style: TextStyle(fontSize: 14.0), // Adjust font size if needed
                          ),
                          onTap: () async {
                            setState(() {
                              _currentAddressController.text =
                              _currentAddressSuggestions[index];
                              _getCoordinatesFromAddress(
                                  _currentAddressSuggestions[index], false);
                              _currentAddressSuggestions = [];
                            });
                          },
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 10.0),

                TextField(
                  controller: _destinationAddressController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _destinationPosition = null;
                        _destinationAddressSuggestions = [];
                      });
                    } else {
                      _getDestinationAddressSuggestions(value);
                    }
                  },
                  onSubmitted: (value) {
                    _getCoordinatesFromAddress(value, true);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.looks_two),
                    hintText: "Enter destination",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _destinationAddressController.clear();
                          _destinationPosition = null;
                          _destinationAddressSuggestions = [];
                          _polylines.clear();
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0), // Reduced padding
                  ),
                ),
                if (_destinationAddressSuggestions.isNotEmpty)
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4.0),
                      ],
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _destinationAddressSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _destinationAddressSuggestions[index],
                            style: TextStyle(fontSize: 14.0),
                          ),
                          onTap: () async {
                            setState(() {
                              _destinationAddressController.text =
                              _destinationAddressSuggestions[index];
                              _getCoordinatesFromAddress(
                                  _destinationAddressSuggestions[index], true);
                              _destinationAddressSuggestions = [];
                            });
                          },
                        );
                      },
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
