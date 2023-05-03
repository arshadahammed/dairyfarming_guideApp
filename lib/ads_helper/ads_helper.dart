import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/2477465193";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/2477465193";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/5376743661";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/5376743661";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3920036584338725/4584753787";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3920036584338725/4584753787";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  //native android
  // ca-app-pub-3940256099942544/2247696110

  //native Ios
  // ca-app-pub-3940256099942544/3986624511
}
