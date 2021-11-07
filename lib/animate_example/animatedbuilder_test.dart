import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AnimatedBuilderTestWidget(),
  ));
}

class AnimatedBuilderTestWidget extends StatefulWidget {
  const AnimatedBuilderTestWidget({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderTeState createState() => _AnimatedBuilderTeState();
}

class _AnimatedBuilderTeState extends State<AnimatedBuilderTestWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          child: Text('hello'), // 性能优化，减少重绘
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 100 * _controller.value,
              // height: 100 * _controller.value,
              height: 100,
              // height: Tween(begin: 0.0, end: 100.0).animate(_controller).value,
              // height: Tween(begin: 0.0, end: 100.0).evaluate(_controller),
              color: Colors.blue,
              alignment: Alignment.center,
              // transform: Matrix4.diagonal3Values(_controller.value, 1.0, 1.0),
              child: child,
            );
          },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _controller.reset();
          _controller.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

