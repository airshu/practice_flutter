/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/chip1.jpg
  AssetGenImage get chip1 => const AssetGenImage('assets/images/chip1.jpg');

  /// File path: assets/images/ic_discovery_normal.png
  AssetGenImage get icDiscoveryNormal =>
      const AssetGenImage('assets/images/ic_discovery_normal.png');

  /// File path: assets/images/ic_discovery_selected.png
  AssetGenImage get icDiscoverySelected =>
      const AssetGenImage('assets/images/ic_discovery_selected.png');

  /// File path: assets/images/ic_home_normal.png
  AssetGenImage get icHomeNormal =>
      const AssetGenImage('assets/images/ic_home_normal.png');

  /// File path: assets/images/ic_home_selected.png
  AssetGenImage get icHomeSelected =>
      const AssetGenImage('assets/images/ic_home_selected.png');

  /// File path: assets/images/ic_hot_normal.png
  AssetGenImage get icHotNormal =>
      const AssetGenImage('assets/images/ic_hot_normal.png');

  /// File path: assets/images/ic_hot_selected.png
  AssetGenImage get icHotSelected =>
      const AssetGenImage('assets/images/ic_hot_selected.png');

  /// File path: assets/images/ic_mine_normal.png
  AssetGenImage get icMineNormal =>
      const AssetGenImage('assets/images/ic_mine_normal.png');

  /// File path: assets/images/ic_mine_selected.png
  AssetGenImage get icMineSelected =>
      const AssetGenImage('assets/images/ic_mine_selected.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/pic1.jpg
  AssetGenImage get pic1 => const AssetGenImage('assets/images/pic1.jpg');

  /// File path: assets/images/pic2.jpg
  AssetGenImage get pic2 => const AssetGenImage('assets/images/pic2.jpg');

  /// File path: assets/images/pic3.jpg
  AssetGenImage get pic3 => const AssetGenImage('assets/images/pic3.jpg');

  /// File path: assets/images/pic4.jpg
  AssetGenImage get pic4 => const AssetGenImage('assets/images/pic4.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        chip1,
        icDiscoveryNormal,
        icDiscoverySelected,
        icHomeNormal,
        icHomeSelected,
        icHotNormal,
        icHotSelected,
        icMineNormal,
        icMineSelected,
        logo,
        pic1,
        pic2,
        pic3,
        pic4
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/alarm-clock-lottie-v440.json
  LottieGenImage get alarmClockLottieV440 =>
      const LottieGenImage('assets/lottie/alarm-clock-lottie-v440.json');

  /// File path: assets/lottie/cat.tgs
  String get cat => 'assets/lottie/cat.tgs';

  /// File path: assets/lottie/hamburger_arrow.json
  LottieGenImage get hamburgerArrow =>
      const LottieGenImage('assets/lottie/hamburger_arrow.json');

  /// List of all assets
  List<dynamic> get values => [alarmClockLottieV440, cat, hamburgerArrow];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
