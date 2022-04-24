main() {
  getEmoji(10).forEach(print);
  getEmojiWithTime(10).forEach(print);
}


Iterable<String> getEmoji(int count) sync* {
  Runes first = Runes('\u{1f47f}');
  for(int i=0; i<count;i++) {
    yield String.fromCharCodes(first.map((e) => e + i));
  }
}

Iterable<String> getEmojiWithTime(int count) sync* {
  yield* getEmoji(count).map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}
