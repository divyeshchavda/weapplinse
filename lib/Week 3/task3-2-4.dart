import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dbhelper.dart';


class task324 extends StatefulWidget {
  const task324({super.key});

  @override
  State<task324> createState() => _task324State();
}

class _task324State extends State<task324> {
  List<Map<String, dynamic>> l = [];

  final db = dbhelper2();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disp();
  }

  void disp() async {
    l = await db.display();
    setState(() {});
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2(Display Data)"),
      ),
      body: l.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                final b = l[index];
                return ListTile(
                  title: Text("${b['name']}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                  trailing: Text("${b['email']}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                  leading: Text("${b['rno']}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                );
              },
            ),
    );
  }
}
