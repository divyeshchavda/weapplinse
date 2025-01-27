import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task236 extends StatefulWidget {
  const task236({super.key});

  @override
  State<task236> createState() => _task236State();
}

class _task236State extends State<task236> {
  var change = 0.00;
  var a = "", d = "";
  var change2 = RangeValues(0, 100);

  void fun(double? value) {
    setState(() {
      change = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Slider Control)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("1.Slider",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Slider(
                      thumbColor: Colors.black,
                      secondaryActiveColor: Colors.black,
                      value: change,
                      min: 0.00,
                      max: 10.00,
                      divisions: 10,
                      activeColor: Colors.blue,
                      onChanged: fun),
                  Center(
                    child: Text('${change.round()}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("2.Range Slider",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    backgroundColor: Colors.black,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  RangeSlider(
                    labels: RangeLabels(
                        '${change2.start.round()}', '${change2.end.round()}'),
                    values: change2,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    onChanged: (RangeValues values) {
                      setState(() {
                        change2 = values; // Update the range values
                      });
                    },
                  ),
                  Center(
                    child: Text(
                        '${change2.start.round()}'
                        "  To  "
                        '${change2.end.round()}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
