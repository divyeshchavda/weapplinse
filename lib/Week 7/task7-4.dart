import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketcoach/Week%207/pay.dart';

import '../Week 2/helper2.dart';

class task714 extends StatefulWidget {
  @override
  _task714State createState() => _task714State();
}

class _task714State extends State<task714> {
  late PaymentService _paymentService;
  var amt = TextEditingController();
  bool check = false;
  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService();
    _paymentService.initialize(
      onSuccess: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Successful")),
        );
      },
      onFailure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Failed")),
        );
      },
      onCancel: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
  }

  @override
  void dispose() {
    _paymentService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razorpay Payment")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Razorpay Payment Gateway",
                      style: GoogleFonts.allison(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/lambo.jpeg"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customtext(
                          label: "Enter Amount In Ruppes",
                          hint: "Enter Amount In Ruppes",
                          controller: amt,
                          icon: Icon(Icons.currency_rupee)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (amt.text.isEmpty == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Enter Amount Its Required"),
                              duration: Duration(milliseconds: 400),
                            ),
                          );
                        } else {
                          if (int.parse(amt.text) < 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Amount Must Be in Positive"),
                                duration: Duration(milliseconds: 400),
                              ),
                            );
                          } else {
                            _paymentService.openCheckout(
                                amt: int.parse(amt.text));
                            Future.delayed(
                              Duration(seconds: 2),
                              () {
                                amt.clear();
                              },
                            );
                          }
                        }
                      },
                      child: Column(
                        children: [
                          Lottie.asset("assets/buy.json",
                              fit: BoxFit.cover, height: 40, width: 40),
                          Text(
                            "Buy Now",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
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
