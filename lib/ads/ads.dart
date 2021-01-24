import 'package:firebase_admob/firebase_admob.dart';
class ShowAds{

  static BannerAd bannerAd;

  static BannerAd _getBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
    );
  }

  static void showBannerAd() {
    bannerAd = _getBannerAd();
    bannerAd..load()..show();
  }

  static void disposeBannerAd() {
    bannerAd = _getBannerAd();
    bannerAd.dispose();
  }

  static InterstitialAd _interstitialAd;
  static InterstitialAd _getInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
    );
  }

  static void showInterstitialAd() {
    _interstitialAd = _getInterstitialAd();
    _interstitialAd..load()
      ..show();
  }

}
