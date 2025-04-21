import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/UI/shop.dart';
import 'package:pocketcoach/UI/shop2.dart';
import 'package:pocketcoach/UI/shop3.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketcoach/UI/shop4.dart';

class screen2 extends StatefulWidget {
  const screen2({super.key});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  bool check = false, check2 = false, check3 = false, check4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
        title: Row(
          children: [
            GestureDetector(onTap:(){
              Navigator.pop(context);
            },child: SvgPicture.asset("assets/icon2/arrowl.svg")),
            SizedBox(width: 8.w,),
            Text(
              "Style Boutique",
              style: GoogleFonts.poppins(
                  color:Color(0xFF3A2764),
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/icon2/search.svg"),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Text("Categories",
                  style: GoogleFonts.poppins(color: Color(0xFF4C4853),
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height * 0.020)),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width * 0.115,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icon2/All.svg",
                            height:
                                MediaQuery.of(context).size.height * 0.050,
                            width: MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("All",
                              style: GoogleFonts.poppins(
                              color: Color(0xFF868093),
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                     10.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.080,
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icon2/cloth.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.050,
                              width:
                                  MediaQuery.of(context).size.height * 0.050,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text("Clothing",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF868093),
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                    10.sp))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: 48.w,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon2/Sunglass.png",
                            height:
                                MediaQuery.of(context).size.height * 0.050,
                            width: MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("Sunglass",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF868093),
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  10.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.080,
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icon2/Bags.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.050,
                              width:
                                  MediaQuery.of(context).size.height * 0.050,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text("Bags",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF868093),
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                    10.sp))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon2/Shoes.png",
                            height:
                                MediaQuery.of(context).size.height * 0.050,
                            width: MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("Shoes",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF868093),
                                  fontWeight: FontWeight.w300,
                                  fontSize:
                                  10.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.080,
                        width: MediaQuery.of(context).size.width * 0.113,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icon2/Watch.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.050,
                              width:
                                  MediaQuery.of(context).size.height * 0.050,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text("Watch",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF868093),
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                    10.sp))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon2/cloth.png",
                            height:
                            MediaQuery.of(context).size.height * 0.050,
                            width:
                            MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("Clothing",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF868093),
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  10.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.080,
                        width: 48.w,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icon2/Sunglass.png",
                              height:
                              MediaQuery.of(context).size.height * 0.050,
                              width: MediaQuery.of(context).size.height * 0.050,
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text("Sunglass",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF868093),
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                    10.sp))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon2/Bags.png",
                            height:
                            MediaQuery.of(context).size.height * 0.050,
                            width:
                            MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("Bags",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF868093),
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  10.sp))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.080,
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icon2/Shoes.png",
                              height:
                              MediaQuery.of(context).size.height * 0.050,
                              width: MediaQuery.of(context).size.height * 0.050,
                            ),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.007,
                            ),
                            Text("Shoes",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF868093),
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                    10.sp))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width * 0.113,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon2/Watch.png",
                            height:
                            MediaQuery.of(context).size.height * 0.050,
                            width:
                            MediaQuery.of(context).size.height * 0.050,
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.007,
                          ),
                          Text("Watch",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF868093),
                                  fontWeight: FontWeight.w300,
                                  fontSize:
                                  10.sp))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 270.h,
                        child: Row(
                          children: [
                            SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width *
                                        0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    255, 243, 231, 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(horizontal:
                                                   5.0,vertical: 5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (check ==
                                                        false) {
                                                      setState(() {
                                                        check = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        check = false;
                                                      });
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .topRight,
                                                        child: Container(
                                                          height: 35.h,
                                                          width: 35.w,
                            
                                                          child: check ==
                                                              false
                                                              ? SvgPicture
                                                              .asset(
                                                            "assets/icon2/Love2.svg",
                                                            height:
                                                            30.h,
                                                            width:
                                                            30.w,
                                                          )
                                                              : SvgPicture
                                                              .asset(
                                                            "assets/icon2/Love.svg",
                                                            height:
                                                            30.h,
                                                            width:
                                                            30.w,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.006,
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: SvgPicture
                                                              .asset(
                                                            "assets/icon2/shop2.svg",
                                                            height: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.041,
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.041,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                top: 20,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => shop(),
                                                        ));
                                                  },
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/UI/img_4.png"),
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.24,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.37,
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Crop Top",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$15.25",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.019,
                                              fontWeight:
                                                  FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop2(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFCDFEA),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check2 ==
                                                    false) {
                                                  setState(() {
                                                    check2 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check2 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,
                            
                                                      child: check2 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 20,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop2(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_5.png"),
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.24,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.37,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Winter Jacket",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$45.50",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 270.h,
                        child: Row(
                          children: [
                            SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop3(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEAF0FF),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check3 ==
                                                    false) {
                                                  setState(() {
                                                    check3 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check3 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,
                            
                                                      child: check3 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop3(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_6.png"),
                                                height: 190.h,
                                                width: 157.89.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Pointed-collar top",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$89.20",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop4(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(255,243,231,0.8),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check4 ==
                                                    false) {
                                                  setState(() {
                                                    check4 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check4 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,
                            
                                                      child: check4 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop4(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_7.png"),
                                                height: 200.h,
                                                width: 160.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "White  T-shirt",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$80.00",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 270.h,
                        child: Row(
                          children: [
                            SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    255, 243, 231, 1.0),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check ==
                                                    false) {
                                                  setState(() {
                                                    check = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,

                                                      child: check ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 20,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_4.png"),
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.24,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.37,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Crop Top",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$15.25",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop2(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFCDFEA),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check2 ==
                                                    false) {
                                                  setState(() {
                                                    check2 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check2 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,

                                                      child: check2 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 20,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop2(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_5.png"),
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.24,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.37,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Winter Jacket",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$45.50",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 270.h,
                        child: Row(
                          children: [
                            SizedBox(width: 3.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop3(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEAF0FF),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check3 ==
                                                    false) {
                                                  setState(() {
                                                    check3 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check3 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,

                                                      child: check3 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop3(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_6.png"),
                                                height: 190.h,
                                                width: 157.89.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Pointed-collar top",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$89.20",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => shop4(),
                                                  ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.267,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(255,243,231,0.8),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal:
                                            5.0,vertical: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (check4 ==
                                                    false) {
                                                  setState(() {
                                                    check4 = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    check4 = false;
                                                  });
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 35.w,

                                                      child: check4 ==
                                                          false
                                                          ? SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love2.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      )
                                                          : SvgPicture
                                                          .asset(
                                                        "assets/icon2/Love.svg",
                                                        height:
                                                        30.h,
                                                        width:
                                                        30.w,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.006,
                                                  ),
                                                  Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/icon2/shop2.svg",
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.041,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.041,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => shop4(),
                                                    ));
                                              },
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/UI/img_7.png"),
                                                height: 200.h,
                                                width: 160.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.006,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "White  T-shirt",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "\$80.00",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xFF2F204F),
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.019,
                                              fontWeight:
                                              FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
