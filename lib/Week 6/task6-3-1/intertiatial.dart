import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class intertiatial extends StatefulWidget {
  const intertiatial({super.key});

  @override
  State<intertiatial> createState() => _intertiatialState();
}

class _intertiatialState extends State<intertiatial> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();

  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test Ad Unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("Ad Loaded");
          setState(() {
            _interstitialAd = ad;
            _isAdLoaded = true;
            _isLoading = false;
          });
        },
        onAdFailedToLoad: (error) {
          print('Interstitial Ad failed to load: $error');
          setState(() {
            _isAdLoaded = false;
            _isLoading = false;
          });
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print('Ad dismissed');
          ad.dispose();
          _loadInterstitialAd(); // Load a new ad after dismissing
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Ad failed to show: $error');
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null; // Set to null to prevent reuse
      _isAdLoaded = false;
    } else {
      print("Ad is not ready yet!");
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interstitial Ad Example")),
      body: Center(
        child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
          onPressed:  _isAdLoaded==true ? _showInterstitialAd : null,
          child: Text("Show Interstitial Ad",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
        ),
      ),
    );
  }
}
