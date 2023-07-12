import 'package:flutter/material.dart';

class TextUtil {

  /// 计算文本的宽度
  /// https://www.jianshu.com/p/cc3e6f78c85d
  static Size boundingTextSize(BuildContext context, String text, TextStyle? style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(context),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
