package com.throwjojo.unity_ads_plugin

import android.app.Activity
import androidx.annotation.NonNull;
import com.unity3d.ads.UnityAds
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** UnityAdsPlugin */
public class UnityAdsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "unity_ads_plugin")
    channel.setMethodCallHandler(UnityAdsPlugin());
  }
  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "unity_ads_plugin")
      channel.setMethodCallHandler(UnityAdsPlugin())
    }

    var mainActivity: Activity? = null
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "initialize") {
      val gameId = call.argument<String>("game_id")
      val testMode = call.argument<Boolean>("test_mode")

      if (mainActivity != null) {
        UnityAds.initialize(mainActivity, gameId, testMode!!)
        result.success(true)
      } else {
        result.success(false)
      }
    } else if (call.method == "show") {
      if (UnityAds.isInitialized() && UnityAds.isReady() && mainActivity != null) {
        UnityAds.show(mainActivity)
        result.success(true)
      } else {
        result.success(false)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mainActivity = binding.activity
  }

  override fun onDetachedFromActivity() {
    mainActivity = null
  }

  override fun onDetachedFromActivityForConfigChanges() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
}
