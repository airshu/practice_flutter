import 'dart:async';

void main() async {
  test1();
}

void test1() async {
  var controller = StreamController();
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.addError('Oops!');
  controller.sink.add(3);
  controller.close();
  await for (var event in controller.stream) {
    print(event);
  }
}

void test2() async {
  var stream = Stream.fromIterable([1, 2, 3, 4, 5]);
  var evenStream = stream.where((event) => event % 2 == 0).map((event) => event * 2);
  await for (var event in evenStream) {
    print(event);
  }
}
