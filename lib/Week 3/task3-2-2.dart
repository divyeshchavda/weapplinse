import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dbhelper.dart';

class task322 extends StatefulWidget {
  const task322({super.key});

  @override
  State<task322> createState() => _task322State();
}

class _task322State extends State<task322> {
  final k = GlobalKey<FormState>();
  var a=TextEditingController();
  var b=TextEditingController();
  var c=TextEditingController();
  var d=TextEditingController();
  final db=dbhelper();
  var rno;
  var name="",city="",rnos="",pass="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task2(Update data)"),
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
              child: TextFormField(
                  controller: b,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: c,
                  decoration: InputDecoration(
                    labelText: 'City',
                    hintText: 'Enter your City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.location_city),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (values){
                  if(values!.length<8){
                    return "Password Must Be Greater Than 8";
                  }
                  return null;
                },
                  controller: d,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.password),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
    if(k.currentState?.validate()??false){
      setState(() {
        rnos=a.text.toString();
        name=b.text.toString();
        city =c.text.toString();
        pass =d.text.toString();
        rno=int.parse(rnos);
        db.update(rno, '$name', '$city','$pass');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Updated Successfully",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white)),
          duration: Duration(seconds: 2),
          shape: Border.all(color: Colors.black),
        ));
        a.clear();
        b.clear();
        c.clear();
        d.clear();
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
