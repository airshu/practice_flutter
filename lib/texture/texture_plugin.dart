

import 'package:flutter/services.dart';

class TexturePlugin {
  static const MethodChannel _channel = MethodChannel('texture_plugin');


  late int textureId;

  Future<int> init(int width, int height) async {
    textureId = await _channel.invokeMethod('init', {
      'width': width,
      'height': height,
    });
    return textureId;
  }

  Future dispose() => _channel.invokeMethod('dispose', {'textureId': textureId});
}