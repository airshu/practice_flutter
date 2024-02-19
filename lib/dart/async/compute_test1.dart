import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  create_new_task();
}

void create_new_task() async{
  var str = 'New Task';
  await compute(doWork, str);
}

void doWork(String message) {
  sleep(Duration(seconds: 2));
  print('new isolate doWork end  message=$message');
}
