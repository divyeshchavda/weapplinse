import 'dart:developer';

import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:flutter/material.dart';

class native2 extends StatefulWidget {
  @override
  _native2State createState() => _native2State();
}

class _native2State extends State<native2> {


  @override
  void initState() {
    super.initState();
    EasyAudienceNetwork.init(
      testMode: true, // Enable test mode
    );
  }





  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native Banner Ad")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Facebook Native Banner Ad Below:"),
          SizedBox(height: 10),
          SafeArea(
            child: NativeAd(
              placementId: NativeAd.testPlacementId, // Use test placement ID
              adType: NativeAdType.NATIVE_BANNER_AD,
              bannerAdSize: NativeBannerAdSize.HEIGHT_100,
              height: 100,
              keepExpandedWhileLoading: true,
              expandAnimationDuraion: 500,
              listener: NativeAdListener(
                onError: (code, message) => log("Native Banner Ad Error: $message"),
                onLoaded: () => log("Native Banner Ad Loaded"),
                onClicked: () => log("Native Banner Ad Clicked"),
                onLoggingImpression: () => log("Native Banner Ad Impression Logged"),
                onMediaDownloaded: () => log("Native Banner Ad Media Downloaded"),
              ),
            ),
          ),
        ],
      )
    );
  }
}
