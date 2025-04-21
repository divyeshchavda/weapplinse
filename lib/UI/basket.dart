import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '1.dart';

class basket extends StatefulWidget {
  const basket({super.key});

  @override
  State<basket> createState() => _basketState();
}

class _basketState extends State<basket> {
  double _offsetX = 0.0;
  final double _maxSwipe = -80;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetX += details.delta.dx;
      if (_offsetX > 0) _offsetX = 0; // Prevent right swipe
      if (_offsetX < _maxSwipe) _offsetX = _maxSwipe; // Restrict left swipe
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _offsetX = _offsetX < _maxSwipe / 2 ? _maxSwipe : 0;
    });
  }
  int qty=1,qty2=1,qty3=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "My Basket",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18.sp,color: Color(0xFF3A2764)),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.h,),
          Container(
            height: 140.h,
            width: 343.w,
            child: SwipeableItem(
              title: "Winter Jacket",
              image: "assets/UI/img_5.png",
              price: "45.50",
              size: "XL",
              color: "Black", name: 'Style Boutique',col: Color.fromRGBO(252, 223, 234, 1.0),
            ),
          ),
          Container(
            height: 140.h,
            width: 343.w,
            child: SwipeableItem(
              title: "Crop Top",
              image: "assets/UI/img_4.png",
              price: "15.25",
              size: "L",
              color: "Red",name: 'Style Boutique',col: Color.fromRGBO(
                255, 243, 231, 1.0),
            ),
          ),
          Container(
            height: 140.h,
            width: 343.w,
            child: SwipeableItem(
              title: "Pointed-collar top",
              image: "assets/UI/img_6.png",
              price: "89.20",
              size: "XL",
              color: "White",name: 'Style Boutique',col: Color.fromRGBO(
                234, 240, 255, 1.0),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.12,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                height: MediaQuery.of(context).size.height*0.072,
                    width: MediaQuery.of(context).size.height*0.42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color.fromRGBO(167, 126, 253, 1.0),Color.fromRGBO(125, 84, 212, 1.0)]),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text("Make an order",style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white),))),
              ],
            )),
          ),
          Center(
            child: Text(
              "No Upfront Payment!",
              style: GoogleFonts.poppins(fontSize: 10.sp,color: Color(0xFF57535F)),
            ),
          ),
        ],
      ),
    );
  }
}
