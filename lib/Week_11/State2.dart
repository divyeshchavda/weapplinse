import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class state2 extends StatefulWidget {
  const state2({super.key});

  @override
  State<state2> createState() => _state2State();
}

class _state2State extends State<state2> {
  final Map<String, dynamic> data = Get.arguments;
  RxInt? touch;
  List<String> names = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    touch = data["click"];
    names = data["data"];
    print(names);
    print(touch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Click: $touch"),
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
      body: names.isEmpty
          ? Center(child: Text("NO DATA FOUND"))
          : ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            names[index],
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
