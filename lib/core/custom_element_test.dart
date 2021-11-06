

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  debugPrintBuildScope = true;

  runApp(MaterialApp(home: CustomHome()));
}

class CustomHome extends Widget {
  @override
  Element createElement() {
    return HomeView(this);
  }
}

class HomeView extends ComponentElement {
  String txt = '123456789';

  HomeView(Widget widget) : super(widget);

  @override
  Widget build() {

    Color color = Theme.of(this).primaryColor;
    return GestureDetector(
      child: Center(
        child: TextButton(
          child: Text(txt, style: TextStyle(color: color),),
          onPressed: (){
            var t = txt.split('')..shuffle();
            txt = t.join();
            markNeedsBuild();
          },
        ),
      ),
    );
  }


}