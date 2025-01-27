import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%202/helper.dart';
import 'package:weapplinse/Week%202/helper2.dart';
import 'package:weapplinse/week.dart';

class task24 extends StatefulWidget {
  const task24({super.key});

  @override
  State<task24> createState() => _task24State();
}

class _task24State extends State<task24> {
  var e=TextEditingController();
  var f=TextEditingController();
  var c=TextEditingController();
  var a=helper();
  var b = week();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 4(Custom Widget Properties)"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: a.customtext("Style 1"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: a.customtext2("Style 2"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btn(btnname: "Custom Button",color: Colors.blue,Callback: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(milliseconds: 300),content: a.customtext2("Custom Widget")));
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btn(btnname: "Custom Button 2",color: Colors.black,Callback: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(milliseconds: 300),content: a.customtext2("Custom Widget 2")));
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customtext(label: "CustomText", hint: "EXAMPLE OF CUSTOM WIDGET", controller: e, icon: Icon(Icons.add)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customtext2(label: "CustomText", hint: "EXAMPLE OF CUSTOM WIDGET", controller: f, icon: Icon(Icons.map)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customtext(label: "Email", hint: "Enter Email", controller: c, icon: Icon(Icons.email)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
