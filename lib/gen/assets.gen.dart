/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/assets
  $LibAssetsGen get assets => const $LibAssetsGen();
}

class $LibAssetsGen {
  const $LibAssetsGen();

  /// Directory path: lib/assets/images
  $LibAssetsImagesGen get images => const $LibAssetsImagesGen();

  /// Directory path: lib/assets/lottie
  $LibAssetsLottieGen get lottie => const $LibAssetsLottieGen();

  /// Directory path: lib/assets/svg
  $LibAssetsSvgGen get svg => const $LibAssetsSvgGen();
}

class $LibAssetsImagesGen {
  const $LibAssetsImagesGen();

  /// File path: lib/assets/images/chat-bubble.png
  AssetGenImage get chatBubble =>
      const AssetGenImage('lib/assets/images/chat-bubble.png');

  /// List of all assets
  List<AssetGenImage> get values => [chatBubble];
}

class $LibAssetsLottieGen {
  const $LibAssetsLottieGen();

  /// File path: lib/assets/lottie/robot.json
  String get robot => 'packages/babylai/lib/assets/lottie/robot.json';

  /// List of all assets
  List<String> get values => [robot];
}

class $LibAssetsSvgGen {
  const $LibAssetsSvgGen();

  /// File path: lib/assets/svg/arrow-broken.svg
  String get arrowBroken => 'packages/babylai/lib/assets/svg/arrow-broken.svg';

  /// File path: lib/assets/svg/chat-bubble.svg
  String get chatBubble => 'packages/babylai/lib/assets/svg/chat-bubble.svg';

  /// File path: lib/assets/svg/circle-back.svg
  String get circleBack => 'packages/babylai/lib/assets/svg/circle-back.svg';

  /// File path: lib/assets/svg/circle-close.svg
  String get circleClose => 'packages/babylai/lib/assets/svg/circle-close.svg';

  /// File path: lib/assets/svg/close.svg
  String get close => 'packages/babylai/lib/assets/svg/close.svg';

  /// File path: lib/assets/svg/full-logo.svg
  String get fullLogo => 'packages/babylai/lib/assets/svg/full-logo.svg';

  /// File path: lib/assets/svg/logo.svg
  String get logo => 'packages/babylai/lib/assets/svg/logo.svg';

  /// File path: lib/assets/svg/person.svg
  String get person => 'packages/babylai/lib/assets/svg/person.svg';

  /// File path: lib/assets/svg/robot.svg
  String get robot => 'packages/babylai/lib/assets/svg/robot.svg';

  /// File path: lib/assets/svg/send-arrow.svg
  String get sendArrow => 'packages/babylai/lib/assets/svg/send-arrow.svg';

  /// File path: lib/assets/svg/send.svg
  String get send => 'packages/babylai/lib/assets/svg/send.svg';

  /// List of all assets
  List<String> get values => [
        arrowBroken,
        chatBubble,
        circleBack,
        circleClose,
        close,
        fullLogo,
        logo,
        person,
        robot,
        sendArrow,
        send
      ];
}

class Assets {
  const Assets._();

  static const String package = 'babylai';

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  static const String package = 'babylai';

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
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
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/babylai/$_assetName';
}
