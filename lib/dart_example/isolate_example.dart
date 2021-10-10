import 'dart:convert';
import 'dart:isolate';

main(List<String> args) {

  test_two_way_isolate();
}

void test_single_isolate() async {
  await start();
}

Isolate? isolate;

start() async {
  //创建接收端口，用来接收子线程消息
  ReceivePort receivePort = ReceivePort();

  //创建并发Isolate，并传入主线程发送端口
  isolate = await Isolate.spawn(entryPoint, receivePort.sendPort);
  //监听子线程消息
  receivePort.listen((data) {
    print('Data：${data.toString()}  ${data.runtimeType}');
  });
}

//并发Isolate
void entryPoint(SendPort sendPort) {
  String jsonString = '''{ "id":"123", "name":"张三", "score" : 95}''';
  Student student = parseJson(jsonString);
  sendPort.send(student);
}

Student parseJson(String json) {
  Map<String, dynamic> map = jsonDecode(json);
  return Student.fromJson(map);
}

class Student {
  String? id;
  String? name;
  int? score;

  Student({this.id, this.name, this.score});

  factory Student.fromJson(Map parsedJson) {
    return Student(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score']);
  }

  @override
  String toString() {
    return '[id=${id},name=${name},score=${score}]';
  }
}


void test_two_way_isolate() async {
  await start2();
  await Future.delayed(Duration(seconds: 1), () {
    threadPort?.send('我来自主线程');
    print('1');
  });
  await Future.delayed(Duration(seconds: 1), () {
    threadPort?.send('我也来自主线程');
    print('2');
  });
  await Future.delayed(Duration(seconds: 1), () {
    threadPort?.send('end');
    print('3');
  });

}

start2() async {
  //创建主线程接收端口，用来接收子线程消息
  ReceivePort receivePort = ReceivePort();

  //创建并发Isolate，并传入主线程发送端口
  isolate = await Isolate.spawn(entryPoint2, receivePort.sendPort);
  //监听子线程消息
  receivePort.listen((data) {
    print('主线程收到来自子线程的消息$data');
    if (data is SendPort) {
      threadPort = data;
    }
  });

}
//子线程发送端口
SendPort? threadPort;

//并发Isolate
void entryPoint2(dynamic message) {
  //创建子线程接收端口，用来接收主线程消息
  ReceivePort receivePort = ReceivePort();

  SendPort sendPort;
  print('==entryPoint==$message');
  if (message is SendPort) {
    sendPort = message;
    print('子线程开启');
    sendPort.send(receivePort.sendPort);
    //监听子线程消息
    receivePort.listen((data) {
      print('子线程收到来自主线程的消息------->  $data');
      assert(data is String);
      if (data == 'end') {
        isolate?.kill();
        isolate = null;
        print('子线程结束');
        return;
      }
    });
    return;
  }
}

