import 'dart:async';

import 'dart:io';

main() {
print('start');
test();
print('end');
}


Future<String> doTask() async {
  sleep(Duration(seconds: 1));
  return 'OK';
}

test() async {
  var r = await doTask();
  print(r);
}