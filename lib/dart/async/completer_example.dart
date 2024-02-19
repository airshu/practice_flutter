


import 'dart:async';

void main() {

  final Completer _completer = Completer();
  _completer.future.then((value) {
    print('Future completed with value: $value');
  }).onError((error, stackTrace) {
    print('Future completed with error: $error');
  });

  // _completer.complete('123123');
  _completer.completeError('aaa');
}
