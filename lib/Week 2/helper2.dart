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
      ),
    );
  }
}

class customtext extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final Icon? icon;

  customtext(
      {required this.label,
      required this.hint,
      required this.controller,
      required this.icon});

  @override
  State<customtext> createState() => _customtextState();
}

class _customtextState extends State<customtext> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      maxLength: 5,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        label: Text(widget.label),
        hintText: widget.hint,
        prefixIcon: widget.icon,
      ),
    );
  }
}

class customtext2 extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final Icon? icon;

  customtext2(
      {required this.label,
      required this.hint,
      required this.controller,
      required this.icon});

  @override
  State<customtext2> createState() => _customtext2State();
}

class _customtext2State extends State<customtext2> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.blue)),
        label: Text(widget.label),
        hintText: widget.hint,
        prefixIcon: widget.icon,
      ),
    );
  }
}
