import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapplinse/Week%201/task7.dart';

class task72 extends StatefulWidget {

  task72( {super.key});
  @override
  State<task72> createState() => _task72State();
}

class _task72State extends State<task72> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
      ),
      body:
          Center(child: Column(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("POP")),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, "/task73");
              }, child: Text("Push Named")),
              ElevatedButton(onPressed: () {
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("It Cant Pop Because It Doesnt have Any Parent Route",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                      duration: Duration(seconds: 2),
                      shape: Border.all(color: Colors.black),
                    ));
                  }
              }, child: Text("can POP?")),
              ElevatedButton(onPressed: () {
                Navigator.maybePop(context);
              }, child: Text("Maybe Pop")),
            ],
          )),
    );
  }

}
