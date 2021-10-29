


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // 需要先初始化底层，才能获取相关信息
  // 初始化一个WidgetsBinding的全局单例
  WidgetsFlutterBinding.ensureInitialized();
  test1();
  runApp(WindowTestApp());
}

void test1() {
  var window = WidgetsBinding.instance?.window;

  print('devicePixelRatio=${window?.devicePixelRatio}');
  print('physicalSize=${window?.physicalSize}');
  print('locale=${window?.locale}');
  print('textScaleFactor=${window?.textScaleFactor}');
}


class WindowTestApp extends StatelessWidget {
  const WindowTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Window测试页面'),),
      ),
    );
  }
}
