import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task237 extends StatefulWidget {
  const task237({super.key});

  @override
  State<task237> createState() => _task237State();
}

class _task237State extends State<task237> {
  var a;
  var result = "";
  var result2 = "";
  var b,c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Pickers Control)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() async {
                    a = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    result = a.toString();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  });
                },
                child: Text("Select Date",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() async {
                    b = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    result2 = b.toString();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result2,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  });
                },
                child: Text("Select Time",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }
}
