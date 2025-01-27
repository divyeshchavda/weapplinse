# weapplinse

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Center(
child: GestureDetector(onScaleStart: (ScaleStartDetails details){
ps=s;
},onScaleUpdate: (ScaleUpdateDetails details){
setState(() {
s=(ps*details.scale).clamp(min, max);
});
},onScaleEnd: (ScaleEndDetails details){
ps=1.0;
},
child: Transform.scale(scale: s,child: Image.asset("assets/img_1.png"))),
),

placelist3.isNotEmpty
? Positioned(
top: 155,
child: Container(
color: Colors.white,
height: 150,
width: 380,
child: ListView.builder(
itemCount: placelist3.length,
itemBuilder: (context, index) {
return ListTile(
title: Text(placelist3[index]["description"]),
onTap: () {
String placeId = placelist3[index]["description"];
String placeId2 = placelist3[index]["place_id"];
setState(() {
_endController.text=placeId;
end=placeId;
_endController.clear();
});
getPlaceDetails3(placeId2);
},
);
},
),
)):

placelist2.isNotEmpty
? Positioned(
top: 155,
child: Container(
color: Colors.white,
height: 150,
width: 380,
child: ListView.builder(
itemCount: placelist2.length,
itemBuilder: (context, index) {
return ListTile(
title: Text(placelist2[index]["description"]),
onTap: () {
String placeId = placelist2[index]["description"];
String placeId2 = placelist2[index]["place_id"];
setState(() {
_startController.text=placeId;
start=_startController.text;
_startController.clear();
});
getPlaceDetails2(placeId2);
},
);
},
),
)):
