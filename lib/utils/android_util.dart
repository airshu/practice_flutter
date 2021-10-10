import 'dart:io';

import 'package:android_intent/android_intent.dart';

/**
 * 回到桌面
 */
backHome() async {
  if (Platform.isAndroid) {
    AndroidIntent intent = const AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: "android.intent.category.HOME",
    );
    await intent.launch();
  }
}
