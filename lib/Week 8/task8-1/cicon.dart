import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cicon extends StatefulWidget {
  const cicon({super.key});

  @override
  State<cicon> createState() => _ciconState();
}

class _ciconState extends State<cicon>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool check = false;
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500), vsync: this,
    );
  }
  void _toggleIcon() {
    setState(() {
      check = !check;
      check ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Icon"),
      ),
      body: Center(
        child: IconButton(
          iconSize: 100,
          icon: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _controller,
          ),
          onPressed: _toggleIcon,
        ),
      ),
    );
  }
}
