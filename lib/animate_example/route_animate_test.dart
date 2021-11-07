import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: Route1Widget()),
    ),
  );
}

class Route1Widget extends StatefulWidget {
  const Route1Widget({Key? key}) : super(key: key);

  @override
  State<Route1Widget> createState() => _Route1WidgetState();
}

class _Route1WidgetState extends State<Route1Widget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          child: Text('Go'),
          onTap: () {
            goPage2(context);
          },
        ),
      ),
    );
  }

  void goPage2(BuildContext context) {

    // Navigator.push(context, FadeRoute(builder: (context) {
    //   return Route2Widget();
    // },));

    //添加路由跳转动画
    Navigator.push(context, PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        // 默认有很多Transition可以使用
        return FadeTransition(
          opacity: animation,
          child: Route2Widget(),
        );
      },
    ));
  }
}

class Route2Widget extends StatelessWidget {
  const Route2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('回去'),),

        ),
      ),
    );
  }
}

/// 自定义route
class FadeRoute extends PageRoute {

  FadeRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 1000),
    this.opaque = true,
    this.barrierLabel,
    this.barrierColor,
    this.maintainState = true,
  });

  @override
  final bool opaque;

  final WidgetBuilder builder;

  @override
  Color? barrierColor;

  @override
  String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if(isActive) {
      return FadeTransition(opacity: animation, child: builder(context),);
    } else {
      return Padding(padding: EdgeInsets.zero);
    }
  }

  @override
  bool maintainState;

  @override
  final Duration transitionDuration;


}