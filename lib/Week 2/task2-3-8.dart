import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class task238 extends StatefulWidget {
  const task238({super.key});

  @override
  State<task238> createState() => _task238State();
}

class _task238State extends State<task238> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.explore),
                    text: "Explore",
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: "Settings",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Text("Home"),
                    ),
                    Center(
                      child: Text("Explore"),
                    ),
                    Center(
                      child: Text("Settings"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
