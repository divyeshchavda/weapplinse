import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketcoach/Week%202/page.dart';
import 'package:pocketcoach/Week%202/page2.dart';
import 'package:pocketcoach/Week%202/page3.dart';

class task239 extends StatefulWidget {
  const task239({super.key});

  @override
  State<task239> createState() => _task239State();
}

class _task239State extends State<task239> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Task3 (Navigation Drawer)"),
        ),
      drawer: Drawer(
        shape: Border.all(style: BorderStyle.solid),backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(radius: 50,backgroundImage: AssetImage("assets/lambo.jpeg"),),
                Text("Divyesh Chavda",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
              ],
            )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("PAGE 1"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => page(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.looks_one),
              title: Text("PAGE 2"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => page2(),),);
              },
            ),
            ListTile(
              leading: Icon(Icons.looks_two),
              title: Text("PAGE 3"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => page3(),), );
              },
            ),
          ],
        ),
      ),
    );
  }
}
