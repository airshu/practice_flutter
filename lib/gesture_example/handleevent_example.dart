import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: PointerDownListener(
          child: Center(child: Text('CLick')),
          onPointerDown: (event) => print('------down------'),
        ),
      ),
    ),
  ));
}

class PointerDownListener extends SingleChildRenderObjectWidget {
  final PointerDownEventListener? onPointerDown;

  PointerDownListener({Key? key, this.onPointerDown, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPointerDownListener()..onPointerDown = onPointerDown;
  }
}

class RenderPointerDownListener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) {
    // return super.hitTestSelf(position);
    return false;
  }

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    print('=-=========$event======');
    if (event is PointerDownEvent) onPointerDown?.call(event);
  }
}
