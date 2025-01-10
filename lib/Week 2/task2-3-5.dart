import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task235 extends StatefulWidget {
  const task235({super.key});

  @override
  State<task235> createState() => _task235State();
}

class _task235State extends State<task235> {
  bool change = false, change2 = false;
  String g1 = "";
  String change3="Surat";

  void fun(bool? value) {
    if (change == false) {
      setState(() {
        change = true;
      });
    } else {
      setState(() {
        change = false;
      });
    }
  }

  void fun2(bool? value) {
    if (change2 == false) {
      setState(() {
        change2 = true;
      });
    } else {
      setState(() {
        change2 = false;
      });
    }
  }

  void fun3(String? value) {
    setState(() {
      g1 = value!;
    });
  }
  void fun4(String? value){
    setState(() {
      change3=value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Selection Controls)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("1. Checkbox",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(change ? "Checked" : "Unchecked",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                Checkbox(activeColor: Colors.blue,
                  checkColor: Colors.white,
                  hoverColor: Colors.red,
                  value: change,
                  onChanged: fun,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("2. Switch",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(change2 ? "ON" : "OFF",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                Switch(activeColor: Colors.white, activeTrackColor: Colors.blue,value: change2, onChanged: fun2),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("3. Radio",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(g1 != null ? "$g1" : "Not Selected",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                Radio(activeColor: Colors.blue,value: "Option 1", groupValue: g1, onChanged: fun3),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(g1 != null ? "$g1" : "Not Selected",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                Radio(activeColor: Colors.blue,value: "Option 2", groupValue: g1, onChanged: fun3),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(g1 != null ? "$g1" : "Not Selected",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                Radio(activeColor: Colors.blue,value: "Option 3", groupValue: g1, onChanged: fun3),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("4. DrowDownButton",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                value: change3,
                items: [
                  DropdownMenuItem(value: "Surat", child: Text("Surat")),
                  DropdownMenuItem(value: "Bhavnagar", child: Text("Bhavnagar")),
                  DropdownMenuItem(value: "Navsari", child: Text("Navsari"))
                ],
                onChanged: fun4),
          )
        ],
      ),
    );
  }
}
