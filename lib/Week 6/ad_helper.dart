import 'dart:developer';
import 'dart:io';
import 'package:easy_audience_network/easy_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdHelper {
  static void init() {
    // Initialize Easy Audience Network
    EasyAudienceNetwork.init(
      testMode: true, // Enable test mode
    );
  }

  /// Show Interstitial Ad
  static void showInterstitialAd(VoidCallback onComplete) {
    final interstitialAd = InterstitialAd(InterstitialAd.testPlacementId);

    interstitialAd.listener = InterstitialAdListener(
      onLoaded: () {
        // Hide loading screen if any
        Get.back();
        onComplete();
        interstitialAd.show();
      },
      onDismissed: () {
        interstitialAd.destroy();
      },
      onError: (code, message) {
        log('Interstitial Ad Error: $message');
        Get.back();
        onComplete();
      },
    );

    interstitialAd.load();
  }

  /// Show Banner Ad
  static Widget bannerAd() {
    return Container(
      alignment: Alignment(0.5, 1),
      child: BannerAd(
        placementId: Platform.isAndroid
            ? BannerAd.testPlacementId
            : BannerAd.testPlacementId,
        bannerSize: BannerSize.STANDARD,
        listener: BannerAdListener(
          onError: (code, message) => print('error'),
          onLoaded: () => print('loaded'),
          onClicked: () => print('clicked'),
          onLoggingImpression: () => print('logging impression'),
        ),
      ),
    );
  }

  /// Show Native Ad
  static Widget nativeAd() {
    return SafeArea(
      child: NativeAd(
        placementId: NativeAd.testPlacementId, // Use test placement ID
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
    );
  }

  /// Show Native Banner Ad
  static Widget nativeBannerAd() {
    return SafeArea(
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
    );
  }
  static void showRewardedAd(VoidCallback onComplete) {
    final rewardedAd = RewardedAd(
      RewardedAd.testPlacementId, // Use test placement ID
      userId: 'test_user', // Optional for server-side verification
    );

    rewardedAd.listener = RewardedAdListener(
      onLoaded: () {
        log("Rewarded Ad Loaded");
        rewardedAd.show();
      },
      onVideoComplete: () {
        log("Rewarded Ad Completed");
        rewardedAd.destroy();
        onComplete(); // Call function after the user finishes watching
      },
      onVideoClosed: () {
        log("Rewarded Ad Closed");
        rewardedAd.destroy();
        onComplete();
      },
      onError: (code, message) {
        log("Rewarded Ad Error: $message");
        rewardedAd.destroy();
        onComplete();
      },
    );

    log("Loading Rewarded Ad...");
    rewardedAd.load(); // Load the rewarded ad
  }
}
