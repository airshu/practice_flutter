import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: testContainer3(),
    ),
  );
}

Widget testContainer3() {
  return Scaffold(
    body: Container(
      color: Colors.blue,
      child: Row(
        children: [
          // Container(
          //   color: Colors.red,
          //   child: Text('He22llo!'),
          // ),
          // Text('Good12bye!'),
        ],
      ),
    ),
  );
}

Widget testContainer2() {
  return Row(
    children: [
      Flexible(
        child: Container(
          color: Colors.red,
          child: const Text(
            'This is a very long text that won\'t fit the line.',
          ),
        ),
      ),
      Flexible(
        child: Container(
          color: Colors.green,
          child: const Text(
            'Goodbye!',
          ),
        ),
      ),
    ],
  );
}

// 最上层是紧约束，使用Center后变成松约束，Container满足约束条件，大小为100x100
Widget testContainer1() {
  return LayoutBuilder(
    builder: (context, constraints) {
      print('2-----${constraints.toString()}');
      return Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            print('3-----${constraints.toString()}');
            return Container(
              height: 100,
              width: 100,
              color: Colors.red,
            );
          },
        ),
      );
    },
  );
}
