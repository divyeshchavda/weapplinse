import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task237 extends StatefulWidget {
  const task237({super.key});

  @override
  State<task237> createState() => _task237State();
}

class _task237State extends State<task237> {
  var a;
  TimeOfDay? selectedTime;
  var result = "";
  var result2 = "";
  var b, c;
  var data = TextEditingController();
  var time = TextEditingController();
  String formatTime(TimeOfDay time) {
    final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final String period = time.period == DayPeriod.am ? "AM" : "PM";
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        selectedTime == null
            ? "No Time Selected"
            : "Selected Time: ${formatTime(selectedTime!)}";
        time.text='${formatTime(selectedTime!)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task3 (Pickers Control)"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
                controller: data,
                decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: 'Enter your Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.data_saver_on),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          a = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          result = a.toString();
                          data.text = result.substring(0, 11);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(result.substring(0, 11),
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width *
                                        0.05,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),
                            duration: Duration(seconds: 2),
                            shape: Border.all(color: Colors.black),
                          ));
                        },
                        icon: Icon(Icons.date_range)))),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
                controller: time,
                decoration: InputDecoration(
                    labelText: 'Time',
                    hintText: 'Enter your Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.data_saver_on),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          _selectTime(context);
                        },
                        icon: Icon(Icons.punch_clock)))),
          ),
        ],
      ),
    );
  }
}
