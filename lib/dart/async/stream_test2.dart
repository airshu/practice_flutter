import 'dart:async';
import 'dart:io';

main() {
  test1();
  // test2();
  // test3();
  // test4();
}

void test1() async {
  Stream<int> stream = Stream.periodic(Duration(seconds: 1), callback);
  // await for (var i in stream) {
  //   print(i);
  // }
  StreamSubscription streamSubscription = stream.listen((event) {
    print(event);
  }, onDone: () {}, onError: (e) {});

  streamSubscription.pause();
  streamSubscription.resume();
}

int callback(int value) {
  return value;
}

void test2() async {
  print('test start');
  Future<String> future = Future(() {
    return 'async task';
  });

  Stream<String> stream = Stream.fromFuture(future);
  await for (var s in stream) {
    print(s);
  }
  print('test end');
}

test3() async {
  print("test start");
  Future<String> fut1 = Future(() {
    // 模拟耗时5秒
    sleep(Duration(seconds: 5));
    return "async task1";
  });
  Future<String> fut2 = Future(() {
    return "async task2";
  });

  // 将多个Future放入一个列表中，将该列表传入
  Stream<String> stream = Stream<String>.fromFutures([fut1, fut2]);
  await for (var s in stream) {
    print(s);
  }
  print("test end");
}

void test4() async {
  Stream stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  await for (var s in stream) {
    print(s);
  }
}

void test5() async {
  Stream<int> stream = Stream.periodic(Duration(seconds: 1), callback);
  stream = stream.take(3); //取三个元素停止
  stream = stream.takeWhile((element) => element < 3); //不满足条件则停止
  stream.skip(3); //跳过几个元素
  await for (var i in stream) {
    print(i);
  }
}
