import 'dart:async';
import 'dart:io';

import 'dart:isolate';

void main() async {

  Future f1 = new Future(() => null);
  Future f2 = new Future(() => null);
  Future f3 = new Future(() => {print("创建f3")});
  f3.then((_) => print("我是f3"));

  f2.then((_) {
    print("我是f2");
    new Future(() => print("我是一个新的"));
    f1.then((_) {
      print("我是f1" );

    });
  }).then((value) => print("我还是f2"));

  // test2();
  // test_then();
  // test_microtoask();
  // test_sync();
  // testThen2();
  // test_wait();
  // testAll();
}

void test_then() {
  Future.value(10).then((value) {
    return value + 10;
  }).then((value) => print(value));
}

// 比较微任务队列和event队列的先后顺序
void test1() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtask #1 of 2'));

  new Future.delayed(
      new Duration(seconds: 1), () => print('future #1 (delayed)'));
  new Future(() => print('future #2 of 3'));
  new Future(() => print('future #3 of 3'));

  scheduleMicrotask(() => print('microtask #2 of 2'));

  print('main #2 of 2');
}

void test2() {
  print('main #1 of 2');
  scheduleMicrotask(() => print('microtask #1 of 3'));

  Future.delayed(Duration(seconds: 1), () => print('future #1 (delayed)'));

  Future(() => print('future #2 of 4'))
      .then((_) => print('future #2a'))
      .then((_) {
    print('future #2b');
    scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
  }).then((_) => print('future #2c'));

  scheduleMicrotask(() => print('microtask #2 of 3'));

  Future(() => print('future #3 of 4'))
      .then((_) => Future(() => print('future #3a (a new future)')))
      .then((_) => print('future #3b'));

  Future(() => print('future #4 of 4'));
  scheduleMicrotask(() => print('microtask #3 of 3'));
  print('main #2 of 2');
}

void test_microtoask() {
  Future.microtask(() {
    print('microtask');
  });

  scheduleMicrotask(() {
    print('scheduleMicrotask');
  });
}

void test_sync() {
  Future.sync(() => 'aaaaaa').then((value) => print(value)).catchError((e) {
    print(e);
  });
}

// 执行顺序测试
void testThen2() {
  Future f2 = Future(() => null);
  Future f1 = Future(() => null);
  Future f3 = Future(() => null);

  f2.then((_) {
    print("f2 -> f2");
    f1.then((_) => print("f2.then -> f1"));
  });
  f1.then((_) => print("f1 -> f1"));
  f3.then((_) => print("f3 -> f3"));
}

void test_wait() {
  Future task1 = Future(() {
    print("task 1");
    //休息500毫秒
    sleep(Duration(milliseconds: 500));
    return 1;
  });

  Future task2 = Future(() {
    print("task 2");
    return 2;
  });

  //延迟1s执行
  Future task3 = Future.delayed(Duration(milliseconds: 1000), () {
    print('task3');
  });

  Future fut = Future.wait([task1, task2, task3]);
  fut.then((responses) {
    print(responses);
  });
}

void testAll() {
  Future f3 = Future(() => null);
  Future f1 = Future(() => null);
  Future f2 = Future(() => null);
  Future f4 = Future(() => null);
  Future f5 = Future(() => null);

  f3.then((_) => print("f3.then -> f3"));
  f2.then((_) => print("f2.then -> f2"));
  f4.then((_) => print("f4.then -> f4"));

  f5.then((_) {
    print("f5.then -> f5");
    Future(() => print("f5.then -> new Future"));
    f1.then((_) {
      print("f1.then -> f1");
    });
  });
}
