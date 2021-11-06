import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  debugPaintPointersEnabled = true;
  return runApp(MaterialApp(
    home: Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (event) => print('22222onPointerDown======>$event'),
      // onPointerUp: (event) => print('222222222onPointerUp======>$event'),
      // onPointerHover: (event) => print('onPointerHover======>$event'),
      // onPointerCancel: (event) => print('onPointerCancel======>$event'),
      // onPointerSignal: (event) => print('onPointerSignal======>$event'),
      // onPointerMove: (event) => print('onPointerMove======>$event'),
      child: Center(
        child: Listener(
          behavior: HitTestBehavior.opaque,
          child: Container(
            child: Center(child: Text('123123')),
            width: 150,
            height: 150,
            color: Colors.grey,
          ),
          onPointerDown: (event) => print('1111111111onPointerDown======>$event'),
          // onPointerUp: (event) => print('1111111111onPointerUp======>$event'),
        ),
      ),
    ),
  ));
}
