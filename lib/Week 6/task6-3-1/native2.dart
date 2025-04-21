import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class native2 extends StatefulWidget {
  const native2({super.key});

  @override
  State<native2> createState() => _native2State();
}

class _native2State extends State<native2> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  String? _versionString;

  void _loadVersionString() {
    MobileAds.instance.getVersionString().then((value) {
      setState(() {
        _versionString = value;
      });
    });
  }

  void nativeVideo() {
    _nativeAd = NativeAd(
        adUnitId: 'ca-app-pub-3940256099942544/1044960115',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print(_nativeAd);
            print('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
          onAdClicked: (ad) {},
          onAdImpression: (ad) {},
          onAdClosed: (ad) {},
          onAdOpened: (ad) {},
          onAdWillDismissScreen: (ad) {},
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.medium,
            mainBackgroundColor: const Color(0xfffffbed),
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)));
    _nativeAd!.load();
  }

  final double _adAspectRatioMedium = (370 / 355);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nativeVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Native Video Ads",
        ),
      ),
      body: Center(
        child: (_nativeAdIsLoaded && _nativeAd != null)?
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
              height: MediaQuery.of(context).size.width *
                  _adAspectRatioMedium,
              width: MediaQuery.of(context).size.width,
              child: AdWidget(ad: _nativeAd!)),
        )
            :
        CircularProgressIndicator(),
      ),
    );
  }
}