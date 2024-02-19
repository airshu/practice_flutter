import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(PluginMyApp());
}

class PluginMyApp extends StatefulWidget {
  const PluginMyApp({super.key});

  @override
  State<PluginMyApp> createState() => _PluginMyAppState();
}

class _PluginMyAppState extends State<PluginMyApp> {
  static const platform = MethodChannel('methodChannelDemo');

  int count = 0;

  @override
  void initState() {
    // 监听底层来的方法回调
    platform.setMethodCallHandler((MethodCall call) async {
      print('>>>>>>>$call');
      if (call.method == 'callDart') {}
    });
    super.initState();
  }

  void test() async {
    // 调用native的方法，第一个参数为方法名，第二个为参数
// 可以设置返回类型
// result为native的方法的返回值
    final result = await platform.invokeMethod<int>('increment', {'count': count});
    count = result ?? 0;
    print('=======result=$result');
    setState(() {});


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              test();
            },
            child: Center(child: Text('hello world  $count'))),
      ),
    );
  }
}
