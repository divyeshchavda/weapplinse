import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week_12/Provider_helper.dart';

import 'Provider_helper.dart';

class provider2 extends StatefulWidget {
  const provider2({super.key});

  @override
  State<provider2> createState() => _provider2State();
}

class _provider2State extends State<provider2> {
  @override
  Widget build(BuildContext context) {
    final Counterhelper=context.watch<counter>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicks:${Counterhelper.count}   Screen 2"),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      width: 50,
                      height: 50,
                      child: InkWell(
                          onTap: () {
Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_double_arrow_left_sharp,
                            size: 30,
                          )),
                    ),
                  )),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(itemCount: Counterhelper.count,itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.blue,
                elevation: 6,
                child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),child: ListTile(title: Center(child: Text('${index+1}',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white))),)),
              ),
            );
          },),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black),
                  onPressed: () {
                    if(Counterhelper.count>0){
                      Counterhelper.decrement();
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Count Not Be Less Than 0'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "-",
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black),
                  onPressed: () {
                    Counterhelper.increment();
                  },
                  child: Text(
                    "+",
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
