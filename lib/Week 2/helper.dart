import 'package:flutter/material.dart';

class helper{
  Widget customtext(String m){
    return Text(m,style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,color: Colors.black));
  }
  Widget customtext2(String m){
    return Text(m,style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        backgroundColor: Colors.black,
        color: Colors.white));
  }
}

