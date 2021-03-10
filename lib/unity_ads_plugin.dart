import 'dart:async';

import 'package:flutter/services.dart';

class UnityAdsPlugin {
  static const MethodChannel _channel = const MethodChannel('unity_ads_plugin');

  static initialize(String gameId, {bool testMode = false}) async {
    await _channel.invokeMethod('initialize', {'game_id': gameId, 'test_mode': testMode});
  }

  static Future<bool> show() async => await _channel.invokeMethod('show') ?? false;
}
