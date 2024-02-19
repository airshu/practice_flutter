import 'package:flutter/material.dart';

class BaseState extends State<StatefulWidget> {
  final String title;

  BaseState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Container();
  }
}

class BaseButtonWidget extends StatefulWidget {
  const BaseButtonWidget({super.key, required this.title, this.onTap});

  final String title;

  final VoidCallback? onTap;

  @override
  State<BaseButtonWidget> createState() => _BaseButtonWidgetState();
}

class _BaseButtonWidgetState extends State<BaseButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        color: Colors.blue,
        height: 40,
        child: Center(
          child: Text(widget.title, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
