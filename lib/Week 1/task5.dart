import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task5 extends StatefulWidget {
  const task5({super.key});

  @override
  State<task5> createState() => _task5State();
}

class _task5State extends State<task5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK 5"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("___Debugging App??___",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("   By That We Can Know About error of our application if any bug found in that then we can identify it and solve it we debug in android studio in 2 way by run the program or by debug button",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.07,fontStyle: FontStyle.italic),),
            )
          ],
        ),
      ),
    );
  }
}
