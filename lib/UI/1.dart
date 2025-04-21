import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeableItem extends StatefulWidget {
  final String title;
  final Color col;
  final String name;
  final String image;
  final String price;
  final String size;
  final String color;

  SwipeableItem({required this.title,required this.col,required this.name, required this.image, required this.price, required this.size, required this.color});

  @override
  _SwipeableItemState createState() => _SwipeableItemState();
}

class _SwipeableItemState extends State<SwipeableItem> {
  int qty=1;
  double _offsetX = 0;
  final double _maxSwipe = -80;
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetX += details.delta.dx;
      if (_offsetX < _maxSwipe) _offsetX = _maxSwipe;
      if (_offsetX > 0) _offsetX = 0;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _offsetX = _offsetX < _maxSwipe / 2 ? _maxSwipe : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
          height: 200.h,
          width: 370.w,
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Set your desired radius
                ),
                child: Container(
                  height: 125.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 109, 89, 1.0),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _offsetX = 0;
                          });
                        },
                        child: Image.asset("assets/icon2/trash.png", width: MediaQuery.of(context).size.width*0.07, height: MediaQuery.of(context).size.height*0.07),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: _offsetX,
                right: -_offsetX,
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Set your desired radius
                    ),
                    child: Container(
                      height: 125.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                height: 62.h,
                                width: 62.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: widget.col,
                                  image: DecorationImage(
                                    image: AssetImage(widget.image),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 125.h,
                            width: 150.w,
                            child: Column(
                              children: [
                                SizedBox(height: 15,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.title,
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF383256),
                                      fontSize:15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Color.fromRGBO(134, 128, 147, 1.0),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.006),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                     Text(
                                        "\$${widget.price}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.006),
                                Row(
                                  children: [
                                     Text(
                                      "Size: ${widget.size}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        color: Color.fromRGBO(134, 128, 147, 1.0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.023),
                                    Text(
                                      "Color: ${widget.color}",
                                      style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height * 0.013,
                                        color: Color.fromRGBO(134, 128, 147, 1.0),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,)
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (qty == 1) {
                                          Fluttertoast.showToast(
                                            msg: "1 Item is Required",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                        } else {
                                          setState(() {
                                            qty = qty - 1;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 26.h,
                                        width: 26.w,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(83, 232, 139, 0.2),
                                              Color.fromRGBO(21, 190, 119, 0.2),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Image.asset("assets/icon2/Path.png"),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 40.w,
                                      child: Center(
                                        child: Text(
                                          "$qty",
                                          style: GoogleFonts.poppins(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (qty == 5) {
                                          Fluttertoast.showToast(
                                            msg: "5 Item is Max",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                        } else {
                                          setState(() {
                                            qty = qty + 1;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 26.h,
                                        width: 26.w,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(83, 232, 139, 1.0),
                                              Color.fromRGBO(21, 190, 119, 1.0),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Image.asset("assets/icon2/Path2.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}