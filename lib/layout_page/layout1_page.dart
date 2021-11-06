import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 系统限制应用最外层的高宽为屏幕的尺寸
/// 布局向下传递约束，向上传递尺寸
/// 这里假设屏幕尺寸为414x896
void main() {
  //1、这里向下约束，限制为
  // 414<=宽度<=414
  // 896<=高度<=896
  runApp(Container(
    //2、由于这里的设置不满足父级约束，所以这里的设置会被忽略
    width: 1,
    height: 1,
    color: Colors.red,
    // Center会允许子集居中，这里的约束会变成
    // 0<=宽度<=414
    // 0<=高度<=896
    child: Center(
      //3、这里的高宽满足父级约束，所以向下传递的约束变为
      // 0<=宽度<=200
      // 0<=高度<=200
      child: Container(
        color: Colors.blue,
        width: 200,
        height: 200,
        //4、约束不满足条件，忽略
        child: FlutterLogo(
          size: 1000,
        ),
      ),
    ),
  ));
  // 5、接下来向上传递尺寸
  // FlutterLogo的尺寸为约束大小200x200
  // 它的父级Container的尺寸为200x200
  // Container的父级Center的尺寸为414x896
  // Center的父级Container的尺寸为414x896
}
