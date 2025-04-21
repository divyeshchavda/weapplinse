import 'package:flutter/material.dart';
import 'package:easy_audience_network/easy_audience_network.dart';

class rewarded2 extends StatefulWidget {
  @override
  _rewarded2State createState() => _rewarded2State();
}

class _rewarded2State extends State<rewarded2> {
  late RewardedAd rewardedAd;
  bool isAdLoaded = false; // Track the ad loading state
  bool _isRewardedAdLoaded = false;
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    EasyAudienceNetwork.init(testingId: "ec07955f-7d2c-41b1-90b9-bc3fd2004f41",testMode: true); // Initialize the network
    _loadRewardedVideoAd();
  }

  // Load the rewarded ad
  void _loadRewardedVideoAd() {
    final rewardedAd = RewardedAd('2312433698835503_2631686356918624');

    rewardedAd.listener = RewardedAdListener(
      onLoaded: () {
        // setState(() {
        //   isAdLoaded = true;  // Set the ad as loaded when it's ready
        // });
        // print("Rewarded Ad Loaded");
        _isRewardedAdLoaded = true;
        print('rewarded ad loaded');
      },
      // onVideoComplete: () {
      //   rewardedAd.destroy();
      //   print("Rewarded Ad Completed");
      // },
      onVideoClosed: () {
        // load next ad already
        rewardedAd.destroy();
        _isRewardedAdLoaded = false;
        _loadRewardedVideoAd();

        // rewardedAd.destroy();
        // setState(() {
        //   isAdLoaded = false;  // Reset after ad is closed
        // });
        // print("Rewarded Ad Closed");
      },
      onError: (code, message) {
        // print("Error: $message");
        // rewardedAd.destroy();
        // setState(() {
        //   isAdLoaded = false;  // Reset if there's an error
        // });
        print('rewarded ad error\ncode = $code\nmessage = $message');
      },
    );
    rewardedAd.load();  // Load the ad
    _rewardedAd = rewardedAd;
    // print("Loading Rewarded Ad...");
  }

  // Show the rewarded ad if it is loaded
  void showRewardedAd() {
    final rewardedAd = _rewardedAd;

    if (rewardedAd != null && _isRewardedAdLoaded) {
      rewardedAd.show();
    } else {
      print("Rewarded Ad not yet loaded!");
    }

    // rewardedAd.load();
    // if (isAdLoaded) {
    //   rewardedAd.show();
    //   print("Displaying Rewarded Ad...");
    // } else {
    //   print("Rewarded Ad is not ready yet.");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewarded Ad Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showRewardedAd,  // Show the ad when the button is pressed
          child: Text('Show Rewarded Ad'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    rewardedAd.destroy();  // Clean up when the widget is disposed
  }
}
