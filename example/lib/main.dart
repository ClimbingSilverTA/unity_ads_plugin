import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    UnityAdsPlugin.initialize("", testMode: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Show Ad'),
            onPressed: () => UnityAdsPlugin.show(),
          ),
        ),
      ),
    );
  }
}
