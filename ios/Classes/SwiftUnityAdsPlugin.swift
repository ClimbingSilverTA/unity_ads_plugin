import Flutter
import UIKit
import UnityAds

public class SwiftUnityAdsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "unity_ads_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftUnityAdsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "initialize") {
            let arguments = call.arguments as! NSDictionary
            let gameId = arguments["game_id"] as! String
            let testMode = arguments["test_mode"] as! Bool
            UnityAds.initialize(gameId, testMode: testMode)
            result(true)
        } else if (call.method == "show") {
            let controller = getRootViewController()
            if UnityAds.isInitialized() && UnityAds.isReady() && controller != nil {
                UnityAds.show(controller!)
                result(true)
            } else {
                result(false)
            }
        }
    }
  
    private func getRootViewController() -> UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
}
