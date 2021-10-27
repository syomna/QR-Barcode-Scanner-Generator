import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6988379612526628/6183259308";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6988379612526628/6183259308";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
