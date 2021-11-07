


import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: ScaleAnimationRoute1()),
    ),
  );
}
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return  Center(
      child: Image.asset(
        "images/logo.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() =>  _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller =  AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到300
    animation =  Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(
      animation: animation,
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}