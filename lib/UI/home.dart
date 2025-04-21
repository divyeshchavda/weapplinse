import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketcoach/UI/screen2.dart';
import 'package:pocketcoach/UI/screen3.dart';
import 'package:pocketcoach/UI/screen4.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var ind = 0;
  PageController _pageController = PageController();
  String change3 = "San francisco, CA";
  final List<String> images = [
    'assets/UI/img.png',
    'assets/UI/img.png',
    'assets/UI/img.png',
    'assets/UI/img.png',
    'assets/UI/img.png',
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
  }

  void fun4(String? value) {
    setState(() {
      change3 = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 200.w,toolbarHeight: 60.h,
        leading: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    "assets/UI/Clip path group.svg",
                    height: 15.29.h,
                    width: 67.w,
                  )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 21.h,
                  width: 139.w,
                  padding: EdgeInsets.only(bottom: 2),
                  // Space for underline
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(125, 84, 212, 0.15),
                            width: 1)), // Thin underline
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: change3,
                        items: [
                          DropdownMenuItem(
                              value: "San francisco, CA",
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icon2/location.svg"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.008,
                                  ),
                                  Text("San francisco, CA",
                                      style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height*0.013,
                                        color:
                                            Color.fromRGBO(134, 128, 147, 1.0),
                                      )),
                                ],
                              )),
                          DropdownMenuItem(
                              value: "Seattle,WA",
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icon2/location.svg"),
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width*0.008,
                                  ),
                                  Text("Seattle,WA",
                                      style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height*0.013,
                                        color:
                                            Color.fromRGBO(134, 128, 147, 1.0),
                                      )),
                                ],
                              )),
                          DropdownMenuItem(
                              value: "Austin,TX",
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icon2/location.svg"),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.008,
                                  ),
                                  Text("Austin,TX",
                                      style: GoogleFonts.poppins(
                                        fontSize: MediaQuery.of(context).size.height*0.013,
                                        color:
                                            Color.fromRGBO(134, 128, 147, 1.0),
                                      )),
                                ],
                              ))
                        ],
                        onChanged: fun4),
                  ),
                ),
              ),
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
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final actualIndex = index % images.length;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                          child: Container(
                            height: 167.h,
                            width: 343.w,
                            child: Image.asset(
                              images[actualIndex],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        spacing: MediaQuery.of(context).size.width*0.013,
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
                      ))
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Nearest Shops",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height*0.02),
                            ),
                          )),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width:15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        height: 37.h,
                        width: 93.w,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(128, 88, 214, 0.11),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(width:10),
                            Text(
                              "Sort By",
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                color: Color.fromRGBO(134, 128, 147, 1.0),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            SvgPicture.asset("assets/icon2/arrow-down.svg",
                                height: 17.h,width: 17.w,
                                color: Color.fromRGBO(134, 128, 147, 1.0))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.013,
                        width: MediaQuery.of(context).size.width*0.25,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(128, 88, 214, 0.11),
                            borderRadius: BorderRadius.circular(10)),child: Row(
                        children: [
                          SizedBox(width:10),
                          SvgPicture.asset("assets/icon2/star.svg",
                              height: 12.h,width: 12.w,
                              color: Color.fromRGBO(134, 128, 147, 1.0)),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              "Top Rated",
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                color: Color.fromRGBO(134, 128, 147, 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                           vertical: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.013,
                        width: 93.w,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(128, 88, 214, 0.11),
                            borderRadius: BorderRadius.circular(10)),child: Row(
                        children: [
                          SizedBox(width:10),
                          Text(
                            "Prices",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Color.fromRGBO(134, 128, 147, 1.0),
                            ),
                          ),
                          SizedBox(width:18),
                          SvgPicture.asset("assets/icon2/arrow-down.svg",
                              height: 17.h,width: 17.w,
                              color: Color.fromRGBO(134, 128, 147, 1.0))
                        ],
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.013,
                        width:93.w,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(128, 88, 214, 0.11),
                            borderRadius: BorderRadius.circular(10)),child: Row(
                        children: [
                          SizedBox(width:10),
                          Text(
                            "Distance",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Color.fromRGBO(134, 128, 147, 1.0),
                            ),
                          ),
                          SizedBox(width:12),
                          SvgPicture.asset("assets/icon2/arrow-down.svg",
                              height: 17.h,width: 17.w,
                              color: Color.fromRGBO(134, 128, 147, 1.0))
                        ],
                      ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 12, child: Container(child:
          ListView(scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: 6.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => screen2(),));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                      height: 115.h,
                      width: 349.07.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:Row(
                        children: [
                          Expanded(flex:1,child: Container(height:95.h,width:95.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/UI/img_1.png"))),)),
                          Expanded(flex:2,child: Container(child: Column(
                            children: [
                              SizedBox(height: 8.h,),
                              Align(alignment:Alignment.topLeft,child: Text("Style Boutique",style: GoogleFonts.poppins(color: Color(0xFF383256),fontSize: 16.sp,fontWeight: FontWeight.w700),)),
                              SizedBox(height: 2.h,),
                              Container(
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 13.h,
                                        width: 31.w,
                                        decoration: BoxDecoration(color: Color(0xFF339D3A),borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 2.w,),
                                           SvgPicture.asset("assets/icon2/star.svg",height: 10.h,width: 10.w,color: Colors.white,),
                                            Text("4.0",style: GoogleFonts.poppins(fontSize: 10.sp,color: Colors.white,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("45 Ratings",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(child: Row(
                                children: [
                                  Align(alignment:Alignment.topLeft,child: SvgPicture.asset("assets/icon2/location.svg",width: 15.w,height: 15.h,)),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.015,),
                                  Text("""18 Shaw Drive, Rathscar Victoria 3465""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                ],
                              ),),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 16.w,),
                                    Text("""(12km)""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icon2/shop.svg",height: 15.h,width: 15.w,),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("Open",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color(0XFF34A621),fontWeight: FontWeight.w500),),
                                    SizedBox(width: 3,),
                                    Text("until 9:30 pm",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)))
                                  ],
                                ),
                              )
                            ],
                          ),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 12),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => screen3(),));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                      height: 115.h,
                      width: 349.07.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Row(
                        children: [
                          Expanded(flex:1,child: Container(height:95.h,width:95.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/UI/img_2.png"))),)),
                          Expanded(flex:2,child: Container(child: Column(
                            children: [
                              SizedBox(height: 8.h,),
                              Align(alignment:Alignment.topLeft,child: Text("Luxe Lane Boutique",style: GoogleFonts.poppins(color: Color(0xFF383256),fontSize: 16.sp,fontWeight: FontWeight.w700),)),
                              SizedBox(height: 2.h,),
                              Container(
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 13.h,
                                        width: 31.w,
                                        decoration: BoxDecoration(color: Color(0xFF339D3A),borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 2.w,),
                                            SvgPicture.asset("assets/icon2/star.svg",height: 10.h,width: 10.w,color: Colors.white,),
                                            Text("3.4",style: GoogleFonts.poppins(fontSize: 10.sp,color: Colors.white,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("38 Ratings",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(child: Row(
                                children: [
                                  Align(alignment:Alignment.topLeft,child: SvgPicture.asset("assets/icon2/location.svg",width: 15.w,height: 15.h,)),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.015,),
                                  Text("""18 Shaw Drive, Rathscar Victoria 3465""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                ],
                              ),),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 16.w,),
                                    Text("""(12km)""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icon2/shop.svg",height: 15.h,width: 15.w,),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("Open",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color(0XFF34A621),fontWeight: FontWeight.w500),),
                                    SizedBox(width: 3,),
                                    Text("until 9:30 pm",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)))
                                  ],
                                ),
                              )
                            ],
                          ),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => screen4(),));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                      height: 115.h,
                      width: 349.07.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Row(
                        children: [
                          Expanded(flex:1,child: Container(height:95.h,width:95.w,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/UI/img_3.png"))),)),
                          Expanded(flex:2,child: Container(child: Column(
                            children: [
                              SizedBox(height: 8.h,),
                              Align(alignment:Alignment.topLeft,child: Text("FashionFlair Emporium",style: GoogleFonts.poppins(color: Color(0xFF383256),fontSize: 16.sp,fontWeight: FontWeight.w700),)),
                              SizedBox(height: 2.h,),
                              Container(
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 13.h,
                                        width: 31.w,
                                        decoration: BoxDecoration(color: Color(0xFF339D3A),borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 2.w,),
                                            SvgPicture.asset("assets/icon2/star.svg",height: 10.h,width: 10.w,color: Colors.white,),
                                            Text("2.7",style: GoogleFonts.poppins(fontSize: 10.sp,color: Colors.white,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("25 Ratings",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(child: Row(
                                children: [
                                  Align(alignment:Alignment.topLeft,child: SvgPicture.asset("assets/icon2/location.svg",width: 15.w,height: 15.h,)),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.015,),
                                  Text("""18 Shaw Drive, Rathscar Victoria 3465""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                ],
                              ),),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 16.w,),
                                    Text("""(12km)""",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)),)
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icon2/shop.svg",height: 15.h,width: 15.w,),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.008,),
                                    Text("Open",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color(0XFF34A621),fontWeight: FontWeight.w500),),
                                    SizedBox(width: 3,),
                                    Text("until 9:30 pm",style: GoogleFonts.poppins(fontSize: 10.sp,color: Color.fromRGBO(134, 128, 147, 1.0)))
                                  ],
                                ),
                              )
                            ],
                          ),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),)),
        ],
      ),
    );
  }
}
