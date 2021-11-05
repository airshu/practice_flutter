import 'package:flutter/material.dart';


void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: SwitcherWidget()),
    ),
  );
}

/**
 *
 * const AnimatedSwitcher({
    Key? key,
    this.child,
    required this.duration, // 新child显示动画时长
    this.reverseDuration,// 旧child隐藏的动画时长
    this.switchInCurve = Curves.linear, // 新child显示的动画曲线
    this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
    })
 *
 */
class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key? key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() => _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              return ScaleTransition(child: child, scale: animation);
            },
            child: Text(
              '$_count',
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          RaisedButton(
            child: const Text('+1',),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}



class SwitcherWidget extends StatefulWidget {
  SwitcherWidget({Key? key}) : super(key: key);

  @override
  State<SwitcherWidget> createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {

  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              AnimatedSwitcher(
                child: Text('$count'),
                duration: Duration(milliseconds: 1200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                  return SlideTransitionX(
                    child: child,
                    direction: AxisDirection.right, //上入下出
                    position: animation,
                  );
                },),
              ElevatedButton(onPressed: () {
                count++;
                setState(() {

                });
              }, child: Text('Increment')),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  // Animation<double> position;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(listenable as Animation<double>);
    print('===================$direction');
    print((listenable as Animation<double>).status);
    if ((listenable as Animation<double>).status == AnimationStatus.reverse) {

      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
