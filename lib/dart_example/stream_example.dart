import 'dart:async';
import 'dart:io';

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

Future<void> test_stream1() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}

void main() {
  // test_stream1();
  // test_periodic();
  // test_fromfuture();
  // test_fromfutures();
  // test_fromIterable();
  // test_listen();
  // test_take();

  // test_streamcontroller();
  // test_streamcontroller2();

  // test_broadcast();
  test_StreamTransformer();
}

void test_StreamTransformer() {

  StreamController sc = StreamController<int>();

  // 创建 StreamTransformer对象
  StreamTransformer stf = StreamTransformer<int, double>.fromHandlers(
    handleData: (int data, EventSink sink) {
      // 操作数据后，转换为 double 类型
      sink.add((data * 2).toDouble());
    },
    handleError: (error, stacktrace, sink) {
      sink.addError('wrong: $error');
    },
    handleDone: (sink) {
      sink.close();
    },
  );

  // 调用流的transform方法，传入转换对象
  Stream stream = sc.stream.transform(stf);

  stream.listen(print);

  // 添加数据，这里的类型是int
  sc.add(1);
  sc.add(2);
  sc.add(3);
}


void test_broadcast() {
  StreamController sc = StreamController.broadcast();

  sc.stream.listen(print);
  sc.stream.listen(print);

  sc.add("event1");
  sc.add("event2");

}

void test_streamcontroller2() {
  // 创建
  StreamController sc = StreamController(
      onListen: ()=>print("onListen"),
      onPause: ()=>print("onPause"),
      onResume: ()=>print("onResume"),
      onCancel: ()=>print("onCancel"),
      sync:false
  );

  StreamSubscription ss = sc.stream.listen(print);

  sc.add('element_1');

  // 暂停
  ss.pause();
  // 恢复
  ss.resume();
  // 取消
  ss.cancel();

  // 关闭流
  sc.close();
}

void test_streamcontroller() {
  // 创建
  StreamController streamController = StreamController();
  // 放入事件
  streamController.add('element_1');
  streamController.addError("this is error");
  streamController.sink.add('element_2');
  streamController.stream
      .listen(print, onError: print, onDone: () => print("onDone"));
}

void test_take() async {
  Stream stream = Stream.periodic(Duration(milliseconds: 500), (count) {
    return count;
  });
  // 获取到第一个元素
  // stream = stream.take(4);

  // 对当前元素进行判断
  stream = stream.takeWhile((x) {
    // 对当前元素进行判断，不满足条件则取消监听
    return x <= 6;
  });

  await for (var i in stream) {
    print(i);
  }

  // stream.forEach((element) {
  //   print(element);
  // });
}

void test_skip() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
  stream = stream.take(5);
  // 表示从Stream中跳过两个元素
  stream = stream.skip(2);

  await for (var i in stream) {
    print(i);
  }
}

void test_tolist() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
  stream = stream.take(5);
  List<int> data = await stream.toList();
  for (var i in data) {
    print(i);
  }
}

void test() async {
  Stream<bool> stream = Stream<bool>.value(false);
  // await for循环从流中读取
  await for (var i in stream) {
    print(i);
  }
}

void test_listen() {
  Stream stream = Stream.fromIterable([1, 2, 3, 4]);
  stream.listen((event) {
    print(event);
  }, onDone: () {
    print('onDone');
  }, onError: (e) {});
}

void test_fromIterable() {
  Stream.fromIterable([1, 2, 3]).forEach((element) {
    print(element);
  });
}

void test_fromfuture() async {
  print("test start");
  Future<String> fut = Future(() {
    return "async task";
  });

  // 从Future创建Stream
  Stream<String> stream = Stream<String>.fromFuture(fut);
  await for (var s in stream) {
    print(s);
  }
  print("test end");
}

void test_fromfutures() async {
  print("test start");
  Future<String> fut1 = Future(() {
    // 模拟耗时5秒
    sleep(Duration(seconds: 3));
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

void test_periodic() async {
  // 使用 periodic 创建流，第一个参数为间隔时间，第二个参数为回调函数
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), callback);
  // await for循环从流中读取
  await for (var i in stream) {
    print(i);
  }
}

// 可以在回调函数中对值进行处理，这里直接返回了
int callback(int value) {
  return value * 1000;
}
