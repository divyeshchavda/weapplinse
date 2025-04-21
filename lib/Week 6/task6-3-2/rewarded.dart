import 'dart:developer';

import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class medium extends StatefulWidget {
  const medium({super.key});

  @override
  State<medium> createState() => _mediumState();
}

class _mediumState extends State<medium> {
  @override
  void initState() {
    super.initState();
    EasyAudienceNetwork.init(
      testMode: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rewarded Ad Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Facebook Medium rectangle Ad Below:",),
            SizedBox(height: 20), // Space between score and button
            Container(
              alignment: Alignment.center,
              child: NativeAd(
                placementId: NativeAd.testPlacementId,
                // Use test placement ID
                adType: NativeAdType.NATIVE_AD,
                // Medium Rectangle falls under Native Ad
                width: 300,
                height: 250,
                backgroundColor: Colors.white,
                keepExpandedWhileLoading: true,
                expandAnimationDuraion: 500,
                listener: NativeAdListener(
                  onLoaded: () => log("Medium Rectangle Ad Loaded"),
                  onError: (code, message) =>
                      log("Medium Rectangle Ad Error: $message"),
                  onClicked: () => log("Medium Rectangle Ad Clicked"),
                  onLoggingImpression: () =>
                      log("Medium Rectangle Ad Impression Logged"),
                  onMediaDownloaded: () =>
                      log("Medium Rectangle Ad Media Downloaded"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
