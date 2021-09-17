import 'package:flutter/material.dart';

/// 动画测试文件
class AnimTestPage extends StatefulWidget {
  const AnimTestPage({Key? key}) : super(key: key);

  @override
  _AnimTestPageState createState() => _AnimTestPageState();
}

class _AnimTestPageState extends State<AnimTestPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print('status=$status');
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

// @override
// Widget build(BuildContext context) {
//   return Center(
//     child: Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       height: animation.value,
//       width: animation.value,
//       child: FlutterLogo(),
//     ),
//   );
// }

// 封装widget
// @override
// Widget build(BuildContext context) {
//   return AnimatedLogo(animation: animation);
// }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(child: LogoWidget(), animation: animation);
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

/// 封装了widget和动画
class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation, Key? key})
      : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
