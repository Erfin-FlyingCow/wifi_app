import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WifiInfoWrapper? _wifiObject;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper? wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject = wifiObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    String nama = "Nama : Muhammad Irfan Noufal";
    String nim = "NIM : 2207411025";
    String ssid = _wifiObject != null ? _wifiObject!.ssid.toString() : "...";
    String mac =
        _wifiObject != null ? _wifiObject!.macAddress.toString() : "...";
    String ipAddress =
        _wifiObject != null ? _wifiObject!.ipAddress.toString() : "...";
    String bssid = _wifiObject != null ? _wifiObject!.bssId.toString() : '...';
    String connectionStrength =
        _wifiObject != null ? _wifiObject!.signalStrength.toString() : '...';
    String connectionType =
        _wifiObject != null ? _wifiObject!.connectionType.toString() : '...';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wifi Info'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Text(nama),
          ),
          Center(
            child: Text(nim),
          ),
          Center(
            child: Text('========================='),
          ),
          Center(
            child: Text('Running on SSID:' + ssid),
          ),
          Center(
            child: Text('Running on IP:' + ipAddress),
          ),
          Center(
            child: Text('Running on MAC:' + mac),
          ),
          Center(
            child: Text('Running on BSSID:' + bssid),
          ),
          Center(
            child: Text('Connection Type:' + connectionType),
          ),
          Center(
            child: Text('Connection Strength:' + connectionStrength),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: initPlatformState,
            child: Text('Get Wi-Fi Info'),
          ),
        ]),
      ),
    );
  }
}
