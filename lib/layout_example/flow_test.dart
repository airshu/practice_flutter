import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: FlowWidget())));
}

class FlowWidget extends StatelessWidget {
  const FlowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flow(
        delegate: MyFlowDelegate(),
        children: [
          Container(width: 80.0, height: 80.0, color: Colors.red),
          Container(width: 80.0, height: 80.0, color: Colors.blue),
          Container(width: 80.0, height: 80.0, color: Colors.green),
          Container(width: 80.0, height: 80.0, color: Colors.black),
          Container(width: 80.0, height: 80.0, color: Colors.purple),
          Container(width: 80.0, height: 80.0, color: Colors.yellow),
          Container(width: 80.0, height: 80.0, color: Colors.brown),
        ],
      ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  var padding = 10;
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = 0.0 + padding;
    var y = 0.0 + padding;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + padding;
      } else {
        x = 0.0 + padding;
        y += context.getChildSize(i)!.height + padding;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + padding;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
