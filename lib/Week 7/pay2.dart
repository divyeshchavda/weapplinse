import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%202/helper2.dart';
import 'stripe.dart';

class stripe extends StatefulWidget {
  const stripe({super.key});

  @override
  State<stripe> createState() => _stripeState();
}

class _stripeState extends State<stripe> {
var amt =TextEditingController();
var name =TextEditingController();
var mono =TextEditingController();
var email =TextEditingController();
bool check =true;
bool isNumber(String text) {
  final regExp = RegExp(r'^-?\d+$');
  return regExp.hasMatch(text);
}
Future<void> process() async {
  try {
    setState(() {
      check=false;
    });
    if(amt.text.isEmpty==true || name.text.isEmpty==true || mono.text.isEmpty==true){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill All Field Its Required"),duration: Duration(milliseconds: 400),));
    }
    else{
      if(mono.text.length==10){
        if(isNumber(mono.text) && isNumber(amt.text)){
          if (int.parse(amt.text) <= 50) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Amount Must Greater Than 50"),
              duration: Duration(milliseconds: 400),
            ));
          } else {
            await StripeService.instance
                .makepayment(amt: int.parse(amt.text), name: name.text, mono: mono.text);
            amt.clear();
            name.clear();
            mono.clear();
          }
        }
        else{
          isNumber(mono.text)?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid Character in Amount"),duration: Duration(milliseconds: 400),)):ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid Character in Mobile No"),duration: Duration(milliseconds: 400),));
        }
        setState(() {
          check=true;
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not Valid Mobile No"),duration: Duration(milliseconds: 400),));
        setState(() {
          check=true;
        });
      }

    }
  } catch (e) {
    print("Error: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: Container(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Stripe Payment Gateway",style: GoogleFonts.allison(
                        fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black),),
                    SizedBox(height: 5,),
                    Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage("assets/lambo.jpeg"))),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: name,
                        maxLength: 20,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Full Name",
                          hintText: "Enter Full Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    )
                    ,
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: mono,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Mobile No",
                          hintText: "Enter Mobile No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.mobile_friendly_sharp),
                        ),
                      ),
                    )
                    ,
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customtext(label: "Enter Amount In Ruppes", hint: "Enter Amount In Ruppes", controller: amt, icon: Icon(Icons.currency_rupee)),
                    )
                    ,ElevatedButton( style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.black,
                    ),
                      onPressed: ()  {
                        check==true?process():null;
                      },
                      child: Text("PAY NOW",style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
