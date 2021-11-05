import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(home: ApplifeCycleTestWidgdet()));
}

class ApplifeCycleTestWidgdet extends StatefulWidget {
  const ApplifeCycleTestWidgdet({Key? key}) : super(key: key);

  @override
  _ApplifeCycleTestWidgdetState createState() => _ApplifeCycleTestWidgdetState();
}

class _ApplifeCycleTestWidgdetState extends State<ApplifeCycleTestWidgdet> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // RenderObject
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetsBindingObserver'),
      ),
    );
  }

  /// 生命周期变化时回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('=====didChangeAppLifecycleState=$state');
    switch (state) {
      // 应用可见并可响应用户操作
      case AppLifecycleState.resumed:
        break;
      //应用可见并可响应用户操作
      case AppLifecycleState.inactive:
        break;
      //应用可见并可响应用户操作
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  /// 低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  /// 应用尺寸发生变化回调（比如旋转）
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  /// 系统字体大小设置修改
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }
}
