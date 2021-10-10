
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterTestPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_test_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 计算两个数的和
  static Future<String?> getResult(int a, int b) async {
    Map<String, dynamic> map = {"a": a, "b": b};
    String result = await _channel.invokeMethod('getResult', map);
    return result;
  }
}
