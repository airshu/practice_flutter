import 'package:flutter/material.dart';

/// Text控件测试
class TextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("aaaa"),
    );
  }
}

class MyUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row();
  }
}


class Text2Page extends StatelessWidget {
  const Text2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Text("asdfasdfdsfdsf"),
      ),
    );
  }
}