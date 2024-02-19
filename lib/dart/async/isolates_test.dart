import 'dart:isolate';

/// 使用Isolate实例
main() {
  // test();
  testComputeLarge();
  // create_isolate();
}

void testComputeLarge() async {
  void longRunningTask(SendPort port) {
// 做一些耗时的操作，例如处理大量数据
    for (int i = 0; i < 1000000000; i++) {
      print(i);
    }
    port.send("Task done");
  }

  var receivePort = ReceivePort();
  Isolate.spawn(longRunningTask, receivePort.sendPort);
  receivePort.listen((message) {
    print(message);
  });
}

void test() async {
  void printMessage(var message) {
    print('Message: $message');
  }

  var receivePort = ReceivePort();
  await Isolate.spawn(printMessage, 'Hello!', onExit: receivePort.sendPort);
  await for (var message in receivePort) {
    print('Received: $message');
  }
}

void test1() {
  void echo(SendPort sender) {
    // 7- make a ReceivePort for the 2nd isolate:
    var port = ReceivePort();
    // 8- send its sendPort to main isolate:
    sender.send(port.sendPort);
    // 9- listen to messages
    port.listen((msg) {
      var data = msg[0];
      print("ISOL: received $msg");
      SendPort replyTo = msg[1];
      replyTo.send('Yes I hear you: $msg, echoed from spawned isolate');
      // 10- received END signal, close the ReceivePort to save
      // resources:
      if (data == "END") {
        print('ISOL: my receive Port will be closed');
        port.close();
      }
    });
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort recv = ReceivePort();
    port.send([msg, recv.sendPort]);
    return recv.first;
  }

  var recv = ReceivePort();
  Future<Isolate> remote = Isolate.spawn(echo, recv.sendPort);
  remote.then((value) => recv.first).then((sendPort) {
    sendReceive(sendPort, 'Do you hear me?').then((msg) {
      print('MAIN: received $msg');
      return sendReceive(sendPort, 'END');
    }).catchError((e) => print('Error in spawning isolate $e'));
  });
}

create_isolate() async {
  ReceivePort rp = ReceivePort();
  SendPort port1 = rp.sendPort;
  Isolate newIsolate =
      await Isolate.spawnUri(Uri(path: './other_task.dart'), ['hello, isolate', 'this is args'], port1);

  SendPort? port2;
  rp.listen((message) {
    print('main isolate message: $message');
    if (message[0] == 0) {
      port2 = message[1];
    } else {
      port2?.send([1, 'this is main isolate send']);
    }
  });
}
