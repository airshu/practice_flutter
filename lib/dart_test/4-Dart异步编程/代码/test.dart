import 'dart:isolate';

main() {
  test1();

  test2();

  print('main over');
}

void test1() async {

  await Isolate.spawn(task, 'hahaha');

  print('test1');
}

void test2() async {
// 创建一个ReceivePort用于接收消息
  var recv = ReceivePort();

  // 创建一个Isolate，泛型参数为SendPort，入口函数为subTask
  // subTask入口函数的参数为SendPort类型，因此spawn第二个参数，传入recv的sendPort对象。
  Isolate.spawn<SendPort>(subTask, recv.sendPort);

  // 使用await等待recv的第一条消息
  var result = await recv.first;

  print("recv: $result");
}

void subTask(SendPort port) {
  port.send('sub task');
}

void task(String msg) {
  print('task $msg');
}
