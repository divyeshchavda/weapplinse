import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class rewarded extends StatefulWidget {
  const rewarded({super.key});

  @override
  State<rewarded> createState() => _rewardedState();
}

class _rewardedState extends State<rewarded> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  int _score = 0; // User's score

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Change to your real Ad Unit ID in production
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print("✅ Rewarded Ad Loaded");
          setState(() {
            _rewardedAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('❌ Rewarded Ad failed to load. Error Code: ${error.code}, Message: ${error.message}');

          setState(() {
            _isAdLoaded = false;
          });

          // Handle specific error codes
          switch (error.code) {
            case 3: // ERROR_CODE_INTERNAL_ERROR
              print("🚨 Internal error. Retrying in 30 seconds...");
              Future.delayed(Duration(seconds: 30), () => _loadRewardedAd());
              break;
            case 2: // ERROR_CODE_NETWORK_ERROR
              print("🌐 Network error. Check internet connection.");
              break;
            case 1: // ERROR_CODE_INVALID_REQUEST
              print("⚠️ Invalid Ad request. Check Ad Unit ID.");
              break;
            case 0: // ERROR_CODE_NO_FILL
              print("🛑 No ads available. Retrying in 60 seconds...");
              Future.delayed(Duration(seconds: 60), () => _loadRewardedAd());
              break;
            default:
              print("⚠️ Unknown error. Retrying in 60 seconds...");
              Future.delayed(Duration(seconds: 60), () => _loadRewardedAd());
          }
        },
      ),
    );
  }


  void _showRewardedAd() {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print("Rewarded Ad Closed😊😊😊");
          ad.dispose();
          setState(() {
            _rewardedAd = null;
            _isAdLoaded = false;
          });
          _loadRewardedAd(); // Load a new ad after dismissal
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("Ad failed to show: $error");
          ad.dispose();
          setState(() {
            _rewardedAd = null;
            _isAdLoaded = false;
          });
          _loadRewardedAd();
        },
      );

      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print("User earned reward: ${reward.amount} ${reward.type}");
          _increaseScore(); // Increase score when the ad is watched
        },
      );


    } else {
      print("Ad is not ready yet!");
    }
  }

  void _increaseScore() {
    setState(() {
      _score += 10; // Increase score by 10
    });
    print("✅ User's new score: $_score");
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
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
              "Score: $_score", // Display the score above the button
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Space between score and button
            ElevatedButton( style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: _isAdLoaded==true ? _showRewardedAd : null,
              child: Text("Watch Ad to Earn Points",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
