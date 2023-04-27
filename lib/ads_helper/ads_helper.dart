import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/8460605996";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/8460605996";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/9989310085";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/9989310085";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/5726631446";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/5726631446";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  //native android
  // ca-app-pub-3940256099942544/2247696110

  //native Ios
  // ca-app-pub-3940256099942544/3986624511
}
