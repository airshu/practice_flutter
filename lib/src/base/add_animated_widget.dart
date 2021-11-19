import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/utils/eventbus_util.dart';

class AddWidget extends StatefulWidget {
  AddWidget({Key? key, this.clicked}) : super(key: key);

  Function? clicked;

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
    lowerBound: 0.0,
    upperBound: 0.16,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  bool isAnimated = false;
  StreamSubscription? subscription;
  @override
  void initState() {
    subscription = EventBusUtil.eventBus.on<AddWidgetEvent>().listen((event) {
      isAnimated = false;
      print('=-======  $isAnimated');
      _controller.reverse();
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void reset() {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('-click---------$isAnimated');
        widget.clicked?.call();
        if (isAnimated) {
          isAnimated = false;
          _controller.reverse();
        } else {
          isAnimated = true;
          _controller.forward();
        }
      },
      child: RotationTransition(
        turns: _animation,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.forward, color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
