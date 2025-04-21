import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week_11/State2.dart';

class state extends StatefulWidget {
  const state({super.key});

  @override
  State<state> createState() => _stateState();
}

class _stateState extends State<state> {
  var name = TextEditingController();
  List<String> data = [];
  RxInt click = 0.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          return Text("Click: $click");
        }),
        actions: [
          Text(
            "GETX",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          click += 1;
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              maxLength: 20,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Full Name",
                hintText: "Enter Full Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              if (name.text.isNotEmpty == true) {
                data.add(name.text);
                name.clear();
                print(data);
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text("Data Added"),
                //   duration: Duration(milliseconds: 500),
                // ));
                Get.snackbar(
                  "Success",
                  "Data Added Successfully",
                  duration: Duration(seconds: 1),
                  backgroundGradient: LinearGradient(
                    colors: [Colors.blue, Colors.greenAccent, Colors.white],
                  ),
                );
              } else {
                Get.snackbar(
                  "Error",
                  "Please Enter Data",
                  duration: Duration(milliseconds: 900),
                  backgroundGradient: LinearGradient(
                    colors: [Colors.blue, Colors.greenAccent, Colors.white],
                  ),
                );
              }
            },
            child: Text(
              "ADD NOW",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Get.to(
                state2(),
                arguments: {"click": click, "data": data},
              );
            },
            child: Text(
              "GO TO SECOND",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
