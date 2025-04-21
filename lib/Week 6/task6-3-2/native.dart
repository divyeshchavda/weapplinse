import 'dart:developer';

import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class native extends StatefulWidget {
  const native({super.key});

  @override
  State<native> createState() => _nativeState();
}

class _nativeState extends State<native> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    EasyAudienceNetwork.init(
      testMode: true, // Enable test mode
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Native Ads",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Facebook Native Ad Below:"),
          SizedBox(height: 10),
          SafeArea(
            child: NativeAd(
              placementId: NativeAd.testPlacementId,
              // Use test placement ID
              adType: NativeAdType.NATIVE_AD,
              keepExpandedWhileLoading: true,
              expandAnimationDuraion: 500,
              listener: NativeAdListener(
                onError: (code, message) => log("Native Ad Error: $message"),
                onLoaded: () => log("Native Ad Loaded"),
                onClicked: () => log("Native Ad Clicked"),
                onLoggingImpression: () => log("Native Ad Impression Logged"),
                onMediaDownloaded: () => log("Native Ad Media Downloaded"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
