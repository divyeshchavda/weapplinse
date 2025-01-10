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

@override
void initState() {
// TODO: implement initState
super.initState();
initialize();
}
void initialize(){
disp();
}
Future<void> disp() async {
final t=await db.display();
setState((){
l=t;
});
print(l);
}


InteractiveViewer(clipBehavior: Clip.none,minScale: 1,maxScale: 4,
child: Image.network("https://img.freepik.com/free-photo/ferocious-lion-with-leaves-background_23-2150852411.jpg")),