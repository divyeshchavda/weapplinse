import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  int ind = 0, _currentPage = 0, col = 1, box = 1;

  bool check = false;
  late Timer _timer;
  PageController _pageController = PageController();
  final List<String> images = [
    "assets/UI/img_4.png",
    "assets/UI/img_4.png",
    "assets/UI/img_4.png",
    "assets/UI/img_4.png",
    "assets/UI/img_4.png"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      int newIndex =
          _pageController.page!.round() % images.length; // Reset index at end
      setState(() {
        ind = newIndex;
        print(ind);
      });
    });
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
  Future<void> _shareImage() async {
    final String customFileName = "Crop Top.jpg"; // Set custom name

    final ByteData bytes = await rootBundle.load('assets/UI/img_4.png');
    final Uint8List list = bytes.buffer.asUint8List();


    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/$customFileName'); // Custom filename
    // Write file
    await file.writeAsBytes(list);

    Share.shareXFiles([XFile(file.path)], text: "Crop Top");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 375.h,
                width: 372.w,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _currentPage = index;
                      },
                      itemBuilder: (context, index) {
                        final actualIndex = index % images.length;
                        return Container(
                            height: 375.h,
                            width: 372.w,
                            color: Color.fromRGBO(255, 243, 231, 1.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                images[actualIndex],
                                height: 323.h,
                                width: 372.w,
                              ),
                            ));
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: GestureDetector(onTap:(){
                        Navigator.pop(context);
                      },child: SvgPicture.asset("assets/icon2/back2.svg")),
                    ),
                    Positioned(
                      top: 50.h,
                      left: 270.w,
                      child: Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (check == false) {
                                  setState(() {
                                    check = true;
                                  });
                                } else {
                                  setState(() {
                                    check = false;
                                  });
                                }
                              },
                              child: SvgPicture.asset(
                                check == false
                                    ? "assets/icon2/Favourite.svg"
                                    : "assets/icon2/Love.svg",
                                height:36.h,
                                width: 36.w,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.035,
                            ),
                            GestureDetector(
                              onTap: (){
                                _shareImage();
                              },
                              child: SvgPicture.asset(
                                "assets/icon2/share2.svg",
                                height:36.h,
                                width: 36.w,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.038,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.038,
                child: Row(
                  spacing: MediaQuery.of(context).size.width * 0.013,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ind == 0
                        ? SvgPicture.asset("assets/icon2/active.svg")
                        : SvgPicture.asset("assets/icon2/inactive.svg"),
                    ind == 1
                        ? SvgPicture.asset("assets/icon2/active.svg")
                        : SvgPicture.asset("assets/icon2/inactive.svg"),
                    ind == 2
                        ? SvgPicture.asset("assets/icon2/active.svg")
                        : SvgPicture.asset("assets/icon2/inactive.svg"),
                    ind == 3
                        ? SvgPicture.asset("assets/icon2/active.svg")
                        : SvgPicture.asset("assets/icon2/inactive.svg"),
                    ind == 4
                        ? SvgPicture.asset("assets/icon2/active.svg")
                        : SvgPicture.asset("assets/icon2/inactive.svg"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Style Boutique",
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.019,
                              color: Color(0xFF6B7280)
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Crop Top",
                            style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.022,
                                fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.035,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xFF339D3A),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SvgPicture.asset("assets/icon2/star.svg",color: Colors.white,height: 14.h,width: 14.w,),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "2.7",
                                      style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.019,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Text(
                              "574 Reviews",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017,
                                  color: Color.fromRGBO(134, 128, 147, 1.0)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "\$15.25",
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.021,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.017,
                            ),
                            Container(
                              child: Stack(
                                children: [
                                  Text(
                                    "\$20.25",
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.013,
                                        color:
                                            Color.fromRGBO(134, 128, 147, 1.0)),
                                  ),
                                  Text(
                                    "------",
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color:
                                            Color.fromRGBO(134, 128, 147, 1.0)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.013,
                            ),
                            Text(
                              "15% OFF",
                              style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  color: Colors.orange.shade900,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Container(
                  height: 60.h,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Colors:",
                            style: GoogleFonts.poppins(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        height: 35.h,
                        child: Row(
                          children: [
                            Container(
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: col == 1 ? 1.0 : 0.0,
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black12)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 3,
                                    left: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          col = 1;
                                        });
                                      },
                                      child: Container(
                                        height: 24.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Color.fromRGBO(
                                              250, 208, 103, 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Opacity(
                                      opacity: col == 2 ? 1.0 : 0.0,
                                      child: Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12)),
                                      ),
                                    ),
                                    Positioned(
                                      top: 3,
                                      left: 3,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            col = 2;
                                          });
                                        },
                                        child: Container(
                                          height: 24.h,
                                          width: 24.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Color.fromRGBO(
                                                103, 206, 250, 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Stack(
                                children: [
                                  Opacity(
                                    opacity: col == 3 ? 1.0 : 0.0,
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black12)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 3,
                                    left: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          col = 3;
                                        });
                                      },
                                      child: Container(
                                        height: 24.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Color.fromRGBO(
                                              250, 156, 103, 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Container(
                                child: Stack(
                                  children: [
                                    Opacity(
                                      opacity: col == 4 ? 1.0 : 0.0,
                                      child: Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12)),
                                      ),
                                    ),
                                    Positioned(
                                      top: 3,
                                      left: 3,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            col = 4;
                                          });
                                        },
                                        child: Container(
                                          height: 24.h,
                                          width: 24.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: Color.fromRGBO(
                                                103, 162, 250, 1.0),
                                          ),
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Container(
                  height: 70.h,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Size",
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  box = 0;
                                });
                              },
                              child: Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: BoxDecoration(
                                    color: box == 0
                                        ? Color.fromRGBO(133, 92, 220, 1.0)
                                        : Colors.white,
                                    border: box == 0
                                        ? Border.all(
                                            color: Colors.black26, width: 0)
                                        : Border.all(
                                            color: Colors.black26, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text("S",
                                        style: GoogleFonts.poppins(
                                            color: box == 0
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    box = 1;
                                  });
                                },
                                child: Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                      color: box == 1
                                          ? Color.fromRGBO(133, 92, 220, 1.0)
                                          : Colors.white,
                                      border: box == 1
                                          ? Border.all(
                                              color: Colors.black26, width: 0)
                                          : Border.all(
                                              color: Colors.black26, width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text("M",
                                          style: GoogleFonts.poppins(
                                              color: box == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  box = 2;
                                });
                              },
                              child: Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: BoxDecoration(
                                    color: box == 2
                                        ? Color.fromRGBO(133, 92, 220, 1.0)
                                        : Colors.white,
                                    border: box == 2
                                        ? Border.all(
                                            color: Colors.black26, width: 0)
                                        : Border.all(
                                            color: Colors.black26, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text("L",
                                        style: GoogleFonts.poppins(
                                            color: box == 2
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    box = 3;
                                  });
                                },
                                child: Container(
                                  height: 32.h,
                                  width: 39.w,
                                  decoration: BoxDecoration(
                                      color: box == 3
                                          ? Color.fromRGBO(133, 92, 220, 1.0)
                                          : Colors.white,
                                      border: box == 3
                                          ? Border.all(
                                              color: Colors.black26, width: 0)
                                          : Border.all(
                                              color: Colors.black26, width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text("XL",
                                          style: GoogleFonts.poppins(
                                              color: box == 3
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500))),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  box = 4;
                                });
                              },
                              child: Container(
                                height: 32.h,
                                width: 47.w,
                                decoration: BoxDecoration(
                                    color: box == 4
                                        ? Color.fromRGBO(133, 92, 220, 1.0)
                                        : Colors.white,
                                    border: box == 4
                                        ? Border.all(
                                            color: Colors.black26, width: 0)
                                        : Border.all(
                                            color: Colors.black26, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text("XXL",
                                        style: GoogleFonts.poppins(
                                            color: box == 4
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Card(
                  elevation: 7,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.259,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 18),
                              child: Text(
                                "Product Details",
                                style: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "•  Fabric",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1.0)),
                                  )),
                              SizedBox(
                                width: 20.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "  -   Cotton",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "•  Length",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1.0)),
                                  )),
                              SizedBox(
                                width: 20.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    " -   Regular",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "•  Neck",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1.0)),
                                  )),
                              SizedBox(
                                width: 24.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "   -   round Neck",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "•  Pattern",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(107, 114, 128, 1.0)),
                                  )),
                              SizedBox(
                                width: 20.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "-   Graphic Print",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) => ProductDetailsSheet(),
                            );
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 40.h,
                              width: 310.w,
                              decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Color.fromRGBO(125, 84, 212, 0.15),
                                        width: 1)),
                              ),
                              child: Row(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 11.0, horizontal: 20),
                                        child: Text(
                                          "View More",
                                          style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(
                                                133,
                                                92,
                                                220,
                                                1.0,
                                              ),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 180.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icon2/arrow.svg",
                                    height: 24.h,
                                    width: 24.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Card(
                  elevation: 7,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.413,
                    width: 328.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Text("Ratings & Reviews",
                                  style: GoogleFonts.inter(fontSize: 14.sp)),
                            )),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 65.h,
                            width: 310.w,
                            decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color.fromRGBO(125, 84, 212, 0.15),
                                      width: 1),
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(125, 84, 212, 0.15),
                                      width: 1)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 39.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text("4.1",
                                                style: GoogleFonts.inter(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text("/5",
                                                style: GoogleFonts.inter(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        107, 114, 128, 1.0))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Container(
                                        height: 39.h,
                                        width: 100.w,
                                        child: Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Overall Rating",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("574 Ratings",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            107,
                                                            114,
                                                            128,
                                                            1.0)))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 60,),
                                      Container(
                                        height: 32.h,
                                        width: 59.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5)
                                            ,border: Border.all(color: Color.fromRGBO(133, 92, 220, 1.0))
                                        ),
                                        child: Center(
                                          child: Text("Rate",style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Color.fromRGBO(133, 92, 220, 1.0))),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(alignment: Alignment.topLeft,child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SvgPicture.asset("assets/icon2/rate.svg",height: 16.h,width: 96.w,),
                        )),
                        SizedBox(
                          height: 5.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: Text(
                                "Amazing!",
                                style: GoogleFonts.inter(
                                    fontSize: 14.sp, fontWeight: FontWeight.w500),
                              ),
                            )),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16.w,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    """An amazing fit. I am somewhere around 6ft and 
ordered 40 size, It's a perfect fit and quality is 
worth the price....""",
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(107, 114, 128, 1.0)),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(alignment: Alignment.topLeft,child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Image.asset("assets/UI/img_8.png",height: 42.h,width: 43.w,),
                        )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: Text(
                                "David Johnson, 1st Jan 2020",
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp, fontWeight: FontWeight.w500,color: Color.fromRGBO(
                                    107, 114, 128, 1.0)),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(msg: "Added To Bag",toastLength: Toast.LENGTH_SHORT);
                },
                child: Container(
                    height: 57.h,
                    width: 326.w,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color.fromRGBO(167, 126, 253, 1.0),Color.fromRGBO(125, 84, 212, 1.0)]),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text("Add to Bag",style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white),))),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ));
  }
}

class ProductDetailsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Container(
                height: 40.h,
                width: 380.w,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(125, 84, 212, 0.15), width: 1)),
                ),
                child: Row(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Product Details",
                            style: GoogleFonts.poppins(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        )),
                    SizedBox(
                      width: 220.w,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 20.w,
                            child: SvgPicture.asset(
                              "assets/icon2/cancel.svg",
                              height: 12.h,
                              width: 12.w,
                            )))
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 7),
                        child: Text(
                          "Specification",
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      )),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Fabric",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 71.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  Cotton",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Length",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 68.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  Regular",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Neck",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 78.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  round Neck",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Pattern",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 64.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  Graphic Print",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Easy Care",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 49.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  Machine wash",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Pure Comfort",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  100% Cotton",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "•  Relaxed Style",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                        SizedBox(
                          width: 30.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "-  Loose Fit",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 7),
                        child: Text(
                          "Description",
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      )),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              """Lorem Ipsum is simply dummy text of the printing and 
typesetting industry. Lorem Ipsum has been the industry's 
standard dummy text ever since the 1500s, when an 
unknown printer took a galley of type and scrambled it to 
make a type specimen book.""",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(107, 114, 128, 1.0)),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
