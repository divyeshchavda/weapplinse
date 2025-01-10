import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dbhelper.dart';

class task323 extends StatefulWidget {
  const task323({super.key});

  @override
  State<task323> createState() => _task323State();
}

class _task323State extends State<task323> {var a=TextEditingController();
final k = GlobalKey<FormState>();
  var b=TextEditingController();
var c=TextEditingController();
final db=dbhelper();
var rno;
var name="",city="",rnos="";
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Task2(Delete data)"),
    ),
    body: Form(
      key: k,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: a,
                validator: (a){
                  if(a==null || a.isEmpty){
                    return "Plz Enter Roll no Its Required";
                  }
                  return null;
                },
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Roll No',
                  hintText: 'Enter your Roll No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.onetwothree),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
  if(k.currentState?.validate()??false){
    setState(() {
      rnos=a.text.toString();
      rno=int.parse(rnos);
      db.delete(rno);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deleted Successfully",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white)),
        duration: Duration(seconds: 2),
        shape: Border.all(color: Colors.black),
      ));
      a.clear();
    });
  }
            }, child: Text("Submit",style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold))),
          )
        ],
      ),
    ),
  );
}
}
