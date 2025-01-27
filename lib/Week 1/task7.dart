import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%201/task6.dart';
import 'package:weapplinse/Week%201/task7-2.dart';
import 'package:weapplinse/Week%201/task7-3.dart';
import 'package:weapplinse/Week%201/week1.dart';

class task7 extends StatefulWidget {
  const task7({super.key});

  @override
  State<task7> createState() => _task7State();
}

class _task7State extends State<task7> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INIT STATE STARTED");
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("Dependencies Changed");
  }
  @override
  void didUpdateWidget(covariant task7 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("Widget Updated" );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("State Disposed" );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 7"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Navigation Push/Pop??",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => task72(),));
            }, child: Text("Push")),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("POP")),
          ],
        ),
      ),
    );
  }
}
