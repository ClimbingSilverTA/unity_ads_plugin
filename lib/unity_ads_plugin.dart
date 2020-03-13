import 'dart:async';

import 'package:flutter/services.dart';

class UnityAdsPlugin {
  static const MethodChannel _channel =
      const MethodChannel('unity_ads_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void init(String appId, {bool testMode = false}) {



  }

}
