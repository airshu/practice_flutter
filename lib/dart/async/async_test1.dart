import 'dart:async';

import 'dart:io';

main() {
// print('start');
// test();
// print('end');

  fetchEmojis(10).forEach(print);
  getEmojiWithTime(10).forEach(print);
}


Future<String> doTask() async {
  sleep(Duration(seconds: 1));
  return 'OK';
}

test() async {
  var r = await doTask();
  print(r);
}


Stream<String> fetchEmojis(int count) async* {
  for(int i=0; i<count; i++) {
    yield await fetchEmoji(i);
  }
}

Future<String> fetchEmoji(int count) async {
  Runes first = Runes('\u{1f474}');
  await Future.delayed(Duration(seconds: 1));
  return String.fromCharCodes(first.map((e) => e + count));
}


Stream<String> getEmojiWithTime(int count) async* {
  yield* fetchEmojis(count).map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}