import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';

class WSAudioPlayer {
  factory WSAudioPlayer() => _getInstance();

  static WSAudioPlayer get instance => _getInstance();
  static WSAudioPlayer? _instance;

  WSAudioPlayer._internal();

  static WSAudioPlayer _getInstance() {
    _instance ??= WSAudioPlayer._internal();
    return _instance!;
  }

  FlutterSoundPlayer? _player;

  Future init() async {
    _player = FlutterSoundPlayer();

    await _player?.openPlayer().then((value) {
      print('WSAudioPlayer init ');
    });
    await _player?.setSubscriptionDuration(const Duration(milliseconds: 100));
    _player?.onProgress?.listen((event) {
      print('WSAudioPlayer onProgress ${event.position}  ${event.duration}');
    });
  }


  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }


  Future playAsset(String path, ) async {
    if (_player == null) {
      await init();
    }
    if (_player?.playerState == PlayerState.isPlaying) {
      await stop();
    }
    print('========123213');
    return _player?.startPlayer(fromDataBuffer: await getAssetData(path));
  }

  Future play(String url, [Function()? onFinished]) async {
    if (_player == null) {
      await init();
    }
    if (_player?.playerState == PlayerState.isPlaying) {
      await stop();
    }
    return _player?.startPlayer(fromURI: url, whenFinished: onFinished);
  }

  Future stop() async {
    await _player?.stopPlayer();
  }
}
