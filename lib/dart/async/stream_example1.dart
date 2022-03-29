

import 'dart:async';

Stream<int> timedCounter(Duration interval, int maxCount) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}

/// 暂停5s后继续运行
void listenWithPause() {
  var counterStream = timedCounter(const Duration(seconds: 1), 15);
  StreamSubscription<int>? subscription;

  subscription = counterStream.listen((int counter) {
    print(counter);
    if(counter == 5) {
      subscription?.pause(Future.delayed(const Duration(seconds: 5)));
    }
  });
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for(var value in stream) {
    sum += value;
  }
  return sum;
}


void main() {
  listenWithPause();
  // timedCounter(Duration(seconds: 1), 5).forEach(print);
  // var counterStream = Stream<int>.periodic(Duration(seconds: 1), (x) => x)
  //     .take(15);//15次事件后停止
  // counterStream
  //     .where((x) => x.isEven) //查询
  //     .expand((element) => [element, element]) //复制每一个元素
  //     .forEach(print);
}
