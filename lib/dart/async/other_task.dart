import 'dart:io';
import 'dart:isolate';

void main(args, SendPort port1) {
  print('isolate_1 start');
  print('isolate_1 args: $args');

  ReceivePort receivePort = ReceivePort();
  SendPort port2 = receivePort.sendPort;

  receivePort.listen((message) {
    print('isolate_1 message: $message');
  });

  port1.send([0, port2]);

  sleep(Duration(seconds: 5));
  port1.send([1, 'isolate_1 task completed']);

  print('isolate_1 stop');
}
