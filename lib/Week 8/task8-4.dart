import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%202/page.dart';
import 'package:pocketcoach/Week%202/page2.dart';
import 'package:pocketcoach/Week%202/page3.dart';
import 'package:popover/popover.dart';

class task84 extends StatefulWidget {
  const task84({super.key});

  @override
  State<task84> createState() => _task84State();
}

class _task84State extends State<task84> {
  void _showMenu(BuildContext context, TapDownDetails details) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx, // X Position
        details.globalPosition.dy, // Y Position
        overlay.size.width - details.globalPosition.dx,
        overlay.size.height - details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'option1',
          child: Text("Option 1"),
        ),
        PopupMenuItem(
          value: 'option2',
          child: Text("Option 2"),
        ),
        PopupMenuItem(
          value: 'option3',
          child: Text("Option 3"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'option1':
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => page(),
                  ));
            }
            break;
          case 'option2':
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => page2(),
                  ));
            }
            break;
          case 'option3':
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => page3(),
                  ));
            }
            break;
          default:
            {
              print("Invalid");
            }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actionsheet"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return CupertinoActionSheet(

                          title: Center(
                              child: Text(
                            "PAGES",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => page(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.looks_one),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Page 1",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => page2(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.looks_two),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Page 2",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => page3(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.three_k),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Page 3",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "SHOW ACTIONSHEET",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}
