import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(home: CustomCenter()));
}

class CustomCenter extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCenter();
  }
}

class RenderCustomCenter extends RenderShiftedBox {
  RenderCustomCenter({RenderBox? child}) : super(child);

  @override
  void performLayout() {
    super.performLayout();

    child!.layout(constraints.loosen(), parentUsesSize: true);

    size = constraints.constrain(Size(constraints.maxWidth == double.infinity ? child!.size.width : double.infinity,
        constraints.maxHeight == double.infinity ? child!.size.height : double.infinity));

    BoxParentData parentData = child!.parentData as BoxParentData;
    parentData.offset = ((size - child!.size) as Offset) / 2;
  }
}
