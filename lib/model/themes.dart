import 'package:flutter/material.dart';

/**
 * 主题管理
 */
class Themes extends ChangeNotifier {
  Color _themeColor = Colors.red;

  Color get themeColor => _themeColor;

  setTheme(Color themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
