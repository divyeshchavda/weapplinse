import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class task42 extends StatefulWidget {
  const task42({super.key});

  @override
  State<task42> createState() => _task42State();
}

class _task42State extends State<task42> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Marker? _userMarker,_userMarker2,_userMarker3;
  bool _isLoading = true;
  LatLng? curloc2 = null;
  var info = "";
  String sessiontoken = '1234567890';
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  List<dynamic> placelist = [];
  List<dynamic> placelist2 = [];
  List<dynamic> placelist3 = [];
  String _apiKey = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
  GoogleMapController? gc;
  var a = TextEditingController();
  double z = 5.00;

  @override
  void initState() {
    super.initState();
    a.addListener(_onChanged);
  }

  void _onChanged() {
    if (sessiontoken == null) {
      setState(() {
        sessiontoken = Random().nextInt(100000000).toString();
      });
    }
    getSuggestion(a.text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$sessiontoken';

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        setState(() {
          placelist = json.decode(response.body)['predictions'];
          print(placelist);
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

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

        if (data['routes'].isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No route found for the given locations.")),
          );
          return;
        }

        String polyline = data['routes'][0]['overview_polyline']['points'];
        List<LatLng> points = _decodePolyline(polyline);

        double startLat = data['routes'][0]['legs'][0]['start_location']['lat'];
        double startLng = data['routes'][0]['legs'][0]['start_location']['lng'];
        double endLat = data['routes'][0]['legs'][0]['end_location']['lat'];
        double endLng = data['routes'][0]['legs'][0]['end_location']['lng'];

        LatLng startLatLng = LatLng(startLat, startLng);
        LatLng endLatLng = LatLng(endLat, endLng);

        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          );

          _markers.add(Marker(
            markerId: MarkerId("start"),
            position: startLatLng,
            infoWindow: InfoWindow(title: "Start Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ));

          _markers.add(Marker(
            markerId: MarkerId("end"),
            position: endLatLng,
            infoWindow: InfoWindow(title: "End Location"),
            icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ));

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
          SnackBar(content: Text("Failed to fetch directions.")),
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


  void getPlaceDetails(String placeId) async {
    const String PLACES_API_KEY = "AIzaSyCpLJbuUUF_cM7UIcSTIJy7-TA3zRAvC3I";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY';

    try {
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        var result = json.decode(response.body)['result'];
        double lat = result['geometry']['location']['lat'];
        double lng = result['geometry']['location']['lng'];

        setState(() {
          curloc2 = LatLng(lat, lng);
          _userMarker=Marker(
            markerId: MarkerId("live"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: curloc2!,
            infoWindow: InfoWindow(
              title: "$info",
            ),
          );
          gc?.animateCamera(
            CameraUpdate.newLatLngZoom(curloc2!, 10),
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
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: curloc2 ?? const LatLng(20.5937, 78.9629),
            zoom: 5,
          ),
          onMapCreated: (controller) {
            gc = controller;
          },
          polylines: _polylines,
          markers:_userMarker!=null? {_userMarker!}:_markers,
          circles: curloc2 != null?{
            Circle(
                circleId: CircleId("live"),
                visible: true,
                radius: 300,
                fillColor: Colors.black12,
                center: LatLng(curloc2!.latitude, curloc2!.longitude),
                strokeColor: Colors.blue,
                strokeWidth: 2)
          }:{},
          compassEnabled: true,
          onTap: (position){
            setState(() {
              _userMarker=Marker(
                markerId: MarkerId("live"),
                icon: BitmapDescriptor.defaultMarker,
                position: position,
                infoWindow: InfoWindow(
                  title: "Lat:${position.latitude.toString().substring(0,5)},Lng:${position.longitude.toString().substring(0,5)}",
                ),
              );
            });
          },

        ),
        Positioned(
          top: 40,
          child: Container(
            height: MediaQuery.of(context).size.height*0.06,
            width: MediaQuery.of(context).size.height*0.45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextField(
              controller: a,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                hintText: "Search your location here",
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    a.clear();
                  },
                ),
              ),
            ),
          ),
        ),
        placelist.isNotEmpty
            ? Positioned(
                top: 90,
                child: Container(
                  color: Colors.white,
                  height: 150,
                  width: 380,
                  child: ListView.builder(
                    itemCount: placelist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placelist[index]["description"]),
                        onTap: () {
                          String placeId = placelist[index]["place_id"];
                          getPlaceDetails(placeId);
                          a.clear();
                        },
                      );
                    },
                  ),
                )):
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: _getUserLocation,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.location_on,
                          size: 35,
                        ),
                      ),
                    )),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  show2();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 35,
                  ),
                ),
              )),
        ),
      ]),
    );
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _userMarker = Marker(
        markerId: MarkerId('current_location'),
        position: _currentPosition!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _isLoading = false;

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 25),
      );
    });
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
                keyboardType: TextInputType.emailAddress,
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
