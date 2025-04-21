import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class banner extends StatefulWidget {
  @override
  _bannerState createState() => _bannerState();
}

class _bannerState extends State<banner> {
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyAudienceNetwork.init(
      testMode: true, // Enable test mode
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Facebook Banner Ad Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Facebook Banner Ad Below:"),
          SizedBox(height: 10),

            SafeArea(
              child: BannerAd(
                placementId: BannerAd.testPlacementId,
                bannerSize: BannerSize.STANDARD,
                listener: BannerAdListener(
                  onError: (code, message) => log("Banner Ad Error: $message"),
                  onLoaded: () => log("Banner Ad Loaded"),
                  onClicked: () => log("Banner Ad Clicked"),
                  onLoggingImpression: () => log("Banner Ad Impression Logged"),
                ),
              ),
            )
        ],
      ),
    );
  }
}
