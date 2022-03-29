import 'dart:isolate';

/// 使用Isolate实例
main() {
  create_isolate();

}

void test1() {
  var recv = ReceivePort();
  Future<Isolate> remote = Isolate.spawn(echo, recv.sendPort);
  remote.then((value) => recv.first).then((sendPort) {
    sendReceive(sendPort, 'Do you hear me?').then((msg) {
      print('MAIN: received $msg');
      return sendReceive(sendPort, 'END');
    }).catchError((e) => print('Error in spawning isolate $e'));
  });
}

void echo(sender) {
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


create_isolate() async {
  ReceivePort rp = ReceivePort();
  SendPort port1 = rp.sendPort;
  Isolate newIsolate = await Isolate.spawnUri(Uri(path: './other_task.dart'), ['hello, isolate', 'this is args'], port1);

  SendPort? port2;
  rp.listen((message) {
    print('main isolate message: $message');
    if(message[0] == 0) {
      port2 = message[1];
    } else {
      port2?.send([1, 'this is main isolate send']);
    }
  });
}

