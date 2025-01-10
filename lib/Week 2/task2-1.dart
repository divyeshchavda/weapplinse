import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%202/task2-1-1.dart';

class task21 extends StatefulWidget {
  const task21({super.key});

  @override
  State<task21> createState() => _task21State();
}

class _task21State extends State<task21> {
  final k = GlobalKey<FormState>();
  var a=TextEditingController();
  var b=TextEditingController();
  var c=TextEditingController();
  var d=TextEditingController();
  var rno;
  var name="",city="",rnos="",pass="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Task1(Data Pass Between 2 page)"),
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
                  keyboardType: TextInputType.number,
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
                  validator: (a){
                    if(a==null || a.isEmpty){
                      return "Plz Enter Name Its Required";
                    }
                    return null;
                  },
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
                  validator: (a){
                    if(a==null || a.isEmpty){
                      return "Plz Enter Its Required";
                    }
                    return null;
                  },
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
                  controller: d,
                  validator: (a){
                    if(a==null || a.isEmpty ){
                      return "Plz Enter Its Required";
                    }
                    if(a.length<8){
                      return "Password Must Be Greater Than 8";
                    }
                    return null;
                  },
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => task211(rno: rnos, name: name, city: city, pass: pass),));
                    a.clear();
                    b.clear();
                    c.clear();
                    d.clear();
                  }
                  );}
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
