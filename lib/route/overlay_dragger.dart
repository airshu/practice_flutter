import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayDraggerWidget extends StatefulWidget {
  const OverlayDraggerWidget({Key? key}) : super(key: key);

  @override
  State<OverlayDraggerWidget> createState() => _OverlayDraggerWidgetState();
}

class _OverlayDraggerWidgetState extends State<OverlayDraggerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          DragOverlay.show(context: context, view: const Scaffold(body: Text('测')));
        },
        child: Center(
          child: Text('点击测试'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    DragOverlay.remove();
    super.dispose();
  }
}

/// 可拖拽悬浮的控件
class DragOverlay {
  static Widget? view;
  static OverlayEntry? _holder;

  static void remove() {
    _holder?.remove();
    _holder = null;
  }

  static void show({required BuildContext context, required Widget view}) {
    DragOverlay.view = view;

    remove();
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        child: _buildDraggable(context),
      );
    });
    Overlay.of(context)!.insert(overlayEntry);
    _holder = overlayEntry;
  }

  static _buildDraggable(context) {
    return Draggable(
      child: view!,
      feedback: view!,
      onDragStarted: () {},
      onDragEnd: (detail) {
        //放手时候创建一个DragTarget
        createDragTarget(offset: detail.offset, context: context);
      },
      //当拖拽的时候就展示空
      childWhenDragging: Container(),
      ignoringFeedbackSemantics: false,
    );
  }

  static void createDragTarget({required Offset offset, required BuildContext context}) {
    if (_holder != null) {
      _holder!.remove();
    }
    _holder = OverlayEntry(builder: (context) {
      bool isLeft = true;
      if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
        isLeft = false;
      }
      double maxY = MediaQuery.of(context).size.height - 100;

      return Positioned(
        top: offset.dy < 50
            ? 50
            : offset.dy > maxY
                ? maxY
                : offset.dy,
        left: isLeft ? 0 : null,
        right: isLeft ? null : 0,
        child: _buildDraggable(context),
      );
    });
    Overlay.of(context)!.insert(_holder!);
  }
}
