import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'profile.dart';
import 'favourite.dart';
import 'basket.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const home(),
    const profile(),
    const basket(),
    const favourite(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': 'assets/icon2/home.svg', 'label': 'Home'},
    {'icon': 'assets/icon2/profile.svg', 'label': 'Profile'},
    {'icon': 'assets/icon2/cartnew.svg', 'label': 'Basket'},
    {'icon': 'assets/icon2/heart.svg', 'label': 'Favourite'},
  ];
  final List<Map<String, dynamic>> _navItems2 = [
    {'icon': 'assets/icon2/home1.svg', 'label': 'Home'},
    {'icon': 'assets/icon2/profile1.svg', 'label': 'Profile'},
    {'icon': 'assets/icon2/cart2.svg', 'label': 'Basket'},
    {'icon': 'assets/icon2/heart-1.svg', 'label': 'Favourite'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 74.h,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _navItems.map((item) {
            int index = _navItems.indexOf(item);
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                height: 44.h,
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: isSelected
                    ? BoxDecoration(
                  color: Color(0xFFF2EEFB),
                  borderRadius: BorderRadius.circular(15),
                )
                    : null,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          isSelected ?_navItems2[index]['icon']:item['icon'],
                          height: 24.h,
                          width: 24.w,
                        ),
                      ],
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          item['label'],
                          style: GoogleFonts.poppins(
                            color: Color(0xFF383256),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


