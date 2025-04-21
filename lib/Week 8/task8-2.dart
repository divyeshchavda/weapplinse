import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class task82 extends StatefulWidget {
  const task82({super.key});

  @override
  State<task82> createState() => _task82State();
}

class _task82State extends State<task82> {
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }
  void _toggleOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responsive App"),),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return PortraitView();
          } else {
            return LandscapeView();
          }
        },
      ),
    );
  }
}
class PortraitView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                image: DecorationImage(image: AssetImage("assets/lambo.jpeg"))
              ),
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("Lamborghini is one of the most iconic luxury sports car manufacturers in the world, renowned for its aggressive styling, high-performance engineering, and cutting-edge technology. Founded in 1963 by Ferruccio Lamborghini, the company was created to rival Ferrari in the world of high-performance automobiles. Based in Sant’Agata Bolognese, Italy, Lamborghini has continued to push the boundaries of automotive innovation, delivering some of the most powerful and exotic vehicles ever built. Today, the company operates under the Volkswagen Group, specifically through its subsidiary Audi, but it has maintained its distinctive identity and commitment to extreme performance.",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LandscapeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          SizedBox(width: 20,),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(image: AssetImage("assets/lambo.jpeg"))
              ),
            ),
          ),
          SizedBox(width: 30,),
          Center(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("""Lamborghini is one of the most iconic luxury sports car 
manufacturers in the world, renowned for its aggressive styling, 
high-performance engineering, and cutting-edge technology. 
Founded in 1963 by Ferruccio Lamborghini, the company was 
created to rival Ferrari in the world of high-performance 
automobiles. Based in Sant’Agata Bolognese, Italy, 
Lamborghini has continued to push the boundaries of 
automotive innovation, delivering some of the most 
powerful and exotic vehicles ever built. Today, the company 
operates under the Volkswagen Group, specifically through 
its subsidiary Audi, but it has maintained its distinctive 
identity and commitment to extreme performance.""",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}