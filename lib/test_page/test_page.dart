import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/main_constraint_test_page.dart';

class TestPage extends StatefulWidget {

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Column(
        children: [
          Text("hahaha"),
          Icon(
            Icons.star,
            color: Colors.blue[500],
          ),

        ],
      ),
    );
  }

  _TestPageState() {
    // testRectangle();
    // testShape();
    testList();
  }

  void testList() {
    Iterable<int> iterable = [1, 2, 3, 4, 5, 6, 7];
    iterable.map((e) => e * 2).forEach((element) {
      print(element);
    });
    print("first=${iterable.first}");
    print("last=${iterable.last}");
    print(iterable.firstWhere((element) => element > 4));
    var foundItem = iterable.firstWhere(
      (item) => item > 10,
      orElse: () => -1,
    );
    print("foundItem=${foundItem}");
    print(iterable.every((element) => element < 13));
    print(iterable.where((element) => element.isEven));
  }

  void testShape() {
    final circle = shapeFactory('circle');
    print(circle);
    final square = shapeFactory('square');
    print(square);
  }

  void testRectangle() {
    print(Rectangle(origin: const Point(10, 20), width: 100, height: 200));
    print(Rectangle(origin: const Point(10, 10)));
    print(Rectangle(width: 200));
    print(Rectangle());
  }

  void testBicycle() {
    var bicycle = Bicycle(2, 1);
    bicycle.speedUp(1);
    print(bicycle);
  }
}

Shape shapeFactory(String type) {
  if (type == 'circle') return Circle(2);
  if (type == 'square') return Square(2);
  throw 'Can\'t create $type.';
}

abstract class Shape {
  num get area;

  @override
  String toString() {
    return runtimeType.toString() + ", area= " + area.toString();
  }
}

class Square extends Shape {
  final num side;

  Square(this.side);

  num get area => pow(side, 2);
}

class Circle extends Shape {
  final num radius;

  Circle(this.radius);

  num get area => pi * pow(radius, 2);
}

class Rectangle {
  int width;
  int height;
  Point origin;

  Rectangle({this.origin = const Point(0, 0), this.width = 0, this.height = 0});

  @override
  String toString() =>
      'Origin: (${origin.x}, ${origin.y}), width: $width, height: $height';
}

class Bicycle {
  int cadence;
  int _speed = 0;
  int gear;

  int get speed => _speed;

  Bicycle(this.cadence, this.gear);

  @override
  String toString() => 'Bicycle: $speed mph';

  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }
}

class DataBloc {
  StreamController<List<String>> _dataController = StreamController();

  StreamSink<List<String>> get _dataSink => _dataController.sink;

  Stream<List<String>> get _dataStream => _dataController.stream;

  late StreamSubscription _dataSubscription;

  init() {
    _dataSubscription = _dataStream.listen((event) {});

    _dataSink.add(["first", "second", "three", "four"]);
  }

  close() {
    _dataSubscription.cancel();
    _dataController.close();
  }

  request() async {
    await Future.delayed(Duration(seconds: 3));
    return "haha";
  }

  doSomething() async {
    String data = await request();
    data = "heihei";
    return data;
  }

  renderSome() {
    doSomething().then((value) {
      print(value);
    });
  }
}





class CustomerStatefulWidget extends StatefulWidget {
  final String _name;

  CustomerStatefulWidget(this._name);

  @override
  State<StatefulWidget> createState() {
    print("TAG, CustomerStatefulWidget:" + _name + "  build");
    return CustomerState("CustomerStateA");
  }
}

class CustomerState extends State<CustomerStatefulWidget> {
  String _name;

  CustomerState(this._name) {
    print("TAG, CustomerState:" + _name + "  构造");
  }

  int _customerStatelessText = 0;

  @override
  Widget build(BuildContext context) {
    print("TAG, " + _name + "  build");
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            MyAppBar(title: Text('目录'),),
            CustomerStatelessWidget("BBB", "BBB"),
            CustomerStatelessWidget(
                "AAA", "AAA:" + _customerStatelessText.toString()),
            GestureDetector(
              onTap: () {
                print("Click My");
                setState(() {
                  _customerStatelessText++;
                });
              },
              child: Text("Click My"),
            )
          ],
        ),
      ),
    );
  }
}

class CustomerStatelessWidget extends StatelessWidget {
  final String _text;
  final String _name;

  CustomerStatelessWidget(this._name, this._text) {
    print("TAG, CustomerStatelessWidget:" + _name + "  构造");
  }

  @override
  Widget build(BuildContext context) {
    print("TAG, CustomerStatelessWidget:" + _name + "  build");
    if (_name == "BBB") {
//      for (int i = 0; i < 10000000; i++) {
//        print("for:" + i.toString());
//      }
      print("我是一个耗时方法，耗时2s");
    }
    return Text(_text);
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({required this.title});

  // Widget子类中的字段往往都会定义为"final"

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row 是水平方向的线性布局（linear layout）
      child: new Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          Icon(Icons.forward),// Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }
}