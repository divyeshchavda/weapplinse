import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class btn extends StatefulWidget {
  final String btnname;
  final Color? color;
  final VoidCallback? Callback;

  const btn({required this.btnname, this.color, this.Callback});

  @override
  State<btn> createState() => _btnState();
}

class _btnState extends State<btn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: widget.color),
        onPressed: () {
          widget.Callback!();
        },
        child: Text(
          widget.btnname,
          style: TextStyle(color: Colors.white),
        ));
  }
}
