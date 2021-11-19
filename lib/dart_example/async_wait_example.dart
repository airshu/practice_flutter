void main() {
  test();

  getEmoji(10).forEach(print);

}



///sync*对应返回Iterable<T>
Iterable<String> getEmoji(int count) sync* {
  Runes first = Runes('\u{1f47f}');
  for (int i = 0; i < count; i++) {
    yield String.fromCharCodes(first.map((e) => e + i));
  }
}

/// yield*后面的表达式是Iterable<T>
Iterable<String> getEmojiWithTime(int count) sync* {
  yield* getEmoji(count).map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}

/// async* 标注的函数，必须返回Stream对象
Stream<String> fetchEmojis(int count) async*{
  for (int i = 0; i < count; i++) {
    yield await fetchEmoji(i);
  }
}

Future<String> fetchEmoji(int count) async {
  Runes first = Runes('\u{1f47f}');
  print('加载开始--${DateTime.now().toIso8601String()}');
  await Future.delayed(Duration(seconds: 2));//模拟耗时
  print('加载结束--${DateTime.now().toIso8601String()}');
  return String.fromCharCodes(first.map((e) => e + count));
}

Stream<String> getEmojiWithTime2(int count) async* {
  yield* fetchEmojis(count).map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}




void test() async {
  // await 方式调用异步方法则代码所在的方法必须添加 async 声明（语法要求）
  // await 方式调用异步方法则会待异步方法执行完成后再执行后续的代码
  String result = await func('1,方法 awiat 关键字调用');
  print('1,---------------------------  $result');

  // 没有使用 await 方式调用异步方法，则异步方法执行到 await 处后等待，程序继续执行异步方法外的后续代码
  func('2,方法直接调用');
  print('2,----------------------------');
}

// 异步方法
func(String callType) async {
  print('$callType ==== 方法内部  await 语句之前 ====');
  return await getData('$callType   == await 执行的语句 ==');
  print('$callType ==== 方法内部  await 语句之后 ====');
}

String getData(String msg) {
  return 'haha: $msg';
}
