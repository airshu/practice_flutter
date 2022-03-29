import 'dart:io';
import 'dart:isolate';

main() {
  print('main isolate start');
  create_isolate();
  print('main isolate end');
}

void create_isolate() async {
  ReceivePort rp = ReceivePort();
  SendPort port1 = rp.sendPort;
  Isolate.spawn(doWork, port1);

  SendPort? port2;
  rp.listen((message) {
    print('main isolate message: $message');
    if(message[0] == 0) {
     port2 = message[1];
    } else {
      port2?.send([1, 'this message is main isolate send']);
    }
  });
}

doWork(SendPort port) {
  print('new isolate start');
  ReceivePort rp2 = ReceivePort();
  SendPort port3 = rp2.sendPort;
  rp2.listen((message) {
    print('doWork message: $message');
  });
  port.send([0, port3]);
  sleep(Duration(seconds: 5));
  port.send([1, 'doWork completed']);
  print('isolate end');
}

