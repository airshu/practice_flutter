import 'package:rxdart/rxdart.dart';

void main() {

  // test1();
  test3();
  // test2();

  // test4();
  // test5();
  // test6();
}


void test1() {

  // 允许多个监听
  var subject = PublishSubject();

  subject.add('======00000');

  subject.listen((value) {
    print('11111Value from first listener: $value');
  });

  subject.add('======11111');

  // 先响应
  subject.listen((value) {
    print('111111  Value from first listener: $value');
  });


  subject.add('1111');
  subject.close();
}

void test3() {

  // 允许多个监听
  var subject = BehaviorSubject();

  subject.add('======00000');

  subject.listen((value) {
    print('3333 Value from first listener: $value');
  });

  subject.add('======33333');

  // 每一个新添加的监听，接收到的第一个数据都是上一个的数据
  subject.listen((value) {
    print('33333 Value from first listener: $value');
  });


  subject.add('33333');
  subject.close();
}

void test2() {
  var subject = BehaviorSubject<int>();

  subject.listen((value) {
    print('Value from first listener: $value');
  });

  subject.add(1);
  subject.add(2);
  subject.listen((value) {
    print('2222  Value from first listener: $value');
  });


  subject.add(3);
  subject.close();
}

void test5() {
  final subject = BehaviorSubject();
  subject.add(1);
  subject.add(2);
  subject.listen(print);
  subject.add(3);
  subject.listen(print);
  subject.stream.listen(print);
}

void test6() {
  final subject = BehaviorSubject<int>.seeded(1);

  subject.stream.listen(print); // prints 1
  subject.stream.listen(print); // prints 1
  subject.stream.listen(print); // prints 1

}


void test4() {
  var subject = ReplaySubject();
  subject.add(1);
  subject.add(2);
  subject.add(3);
  //回访已经推送过的数据
  subject.listen((value) {
    print('Value from first listener: $value');
  });
}