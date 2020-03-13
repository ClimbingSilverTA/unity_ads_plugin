import 'dart:async';

import 'package:flutter/services.dart';

class UnityAdsPlugin {
  static const MethodChannel _channel =
      const MethodChannel('unity_ads_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static initialize(String gameId, {bool testMode = false}) async {
    await _channel.invokeMethod('initialize', {
      'game_id': gameId,
      'test_mode': testMode
    });
  }

  static Future<bool> show() async {
    return await _channel.invokeMethod('show');
  }

}
