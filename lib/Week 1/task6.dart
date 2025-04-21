import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task6 extends StatefulWidget {
  const task6({super.key});

  @override
  State<task6> createState() => _task6State();
}

class _task6State extends State<task6> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Add observer for lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    // Show SnackBar after initState is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("initState called");
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Show SnackBar after didChangeDependencies is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("didChangeDependencies called");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show SnackBar after build is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("build called");
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("TASK 6"),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "View Controller Lifecycle/Activity",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.09,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  backgroundColor: Colors.black,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    """   In Stateless Widget, we have only one activity: build(), but in Stateful Widget, we have activities like build(), initState(), setState(), dispose().
        
        Flutter Specific Callback LifeCycle:
        
        resumed: The app is in the foreground and active.
   
        inactive: The app is transitioning between states, such as when a phone call is received.    
                          
        paused: The app is in the background and not visible.

        detached: The app is still hosted on a Flutter engine but detached from any host views.""",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant task6 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Show SnackBar after didUpdateWidget is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("didUpdateWidget called");
      },
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    // Show SnackBar after setState is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("setState called");
      },
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    // Show SnackBar after deactivate is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("deactivate called");
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this); // Remove observer when not needed
    super.dispose();
    // Show SnackBar after dispose is called
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showSnackBar("dispose called");
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    String message = "";

    switch (state) {
      case AppLifecycleState.resumed:
        message = "The app is in the foreground and active.";
        break;
      case AppLifecycleState.inactive:
        message = "The app is transitioning between states.";
        break;
      case AppLifecycleState.paused:
        message = "The app is in the background and not visible.";
        break;
      case AppLifecycleState.detached:
        message =
            "The app is still hosted on a Flutter engine but detached from any host views.";
        break;
      case AppLifecycleState.hidden:
        throw UnimplementedError();
    }

    // Show a SnackBar when app lifecycle state changes
    if (message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _showSnackBar(message);
        },
      );
    }
  }

  // Method to show the SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 300),
      ),
    );
  }
}
