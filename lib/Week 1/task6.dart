import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task6 extends StatefulWidget {
  const task6({super.key});

  @override
  State<task6> createState() => _task6State();
}

class _task6State extends State<task6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK 6"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("view controller life cycle/activity",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,backgroundColor: Colors.black,color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(""""   In Stateless Widget We have only one activity and its build() but In Stateful Widget it have activity like build(),initstate(),setstate(),dispose()    

        Flutter Specific Callback LifeCycle
        
resumed: The app is in the foreground and active.
   
inactive: The app is transitioning between states, such as when a phone call is received.    
                          
paused: The app is in the background and not visible.

detached: The app is still hosted on a Flutter engine but detached from any host views""",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,fontStyle: FontStyle.italic),),
            )
          ],
        ),
      ),
    );
  }
}
