import 'package:flutter/material.dart';



void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: AnimationDemo(),
    ),
  ));
}


class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationDemo();
}

class _AnimationDemo extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = Tween(begin: 0.1, end: 1.5).animate(_animationController);

    //开始动画
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.blue,
      height: 200,
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}



