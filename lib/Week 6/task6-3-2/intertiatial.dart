import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_audience_network/easy_audience_network.dart';

class intertiatial extends StatefulWidget {
  const intertiatial({super.key});

  @override
  State<intertiatial> createState() => _intertiatialState();
}

class _intertiatialState extends State<intertiatial> {
  @override
  void initState() {
    super.initState();
    EasyAudienceNetwork.init(
      testMode: true, // Enable test mode
    );
  }
  static void showInterstitialAd(VoidCallback onComplete) {
    final interstitialAd = InterstitialAd(InterstitialAd.testPlacementId);

    interstitialAd.listener = InterstitialAdListener(
      onLoaded: () {
        onComplete();
        interstitialAd.show();
      },
      onDismissed: () {
        interstitialAd.destroy();
      },
      onError: (code, message) {
        log('Interstitial Ad Error: $message');
        onComplete();
      },
    );

    interstitialAd.load();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interstitial Ad Example")),
      body: Center(
        child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
          onPressed:  (){
          showInterstitialAd(()=>print("Complete"));
          },
          child: Text("Show Interstitial Ad",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
        ),
      ),
    );
  }
}
