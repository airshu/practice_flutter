

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: PageTestWidget())));
}

class PageTestWidget extends StatelessWidget {
  const PageTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    // 生成 6 个 Tab 页
    for (int i = 0; i < 6; ++i) {
      children.add( Page( text: '$i'));
    }

    return PageView(
      // scrollDirection: Axis.vertical, // 滑动方向为垂直方向
      children: children,
    );
  }
}


class Page extends StatefulWidget {
  const Page({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);//要调用到混入类的代码，需要super
    print("=====================================build ${widget.text}");
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }

  @override
  bool get wantKeepAlive => true;
}