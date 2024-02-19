import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Resource {
  String data = 'Resource Data';
  void dispose() {
    data = '';
    print('Resource disposed');
  }
}

void main() {


  Stream.periodic(Duration(milliseconds: 100), (i) => i)
      .buffer(Stream.periodic(Duration(milliseconds: 160), (i) => i))
      .listen(print); // prints [0, 1] [2, 3] [4, 5] ...

  RangeStream(1, 4).bufferCount(2).listen(print); // prints [1, 2], [3, 4] done!

  //startBufferEvery 表示跳过几个元素开始新的buffer
  RangeStream(1, 5).bufferCount(3, 2).listen(print); // prints [1, 2, 3], [3, 4, 5], [5] done!

  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .bufferTest((i) => i % 2 == 0)
      .listen(print); // prints [0], [1, 2] [3, 4] [5, 6] ...

  Stream.periodic(Duration(milliseconds: 100), (int i) => i)
      .bufferTime(Duration(milliseconds: 220))
      .listen(print); // prints [0, 1] [2, 3] [4, 5] ...
  //
  TimerStream(1, Duration(seconds: 10))
      .concatWith([Stream.fromIterable([2])])
      .listen(print); // prints 1, 2

  Stream.fromIterable([1, 2, 3, 4])
      .debounce((_) => TimerStream(false, Duration(seconds: 10)))
      .listen(print); // prints 4

  Stream.fromIterable([1, 2, 3, 4])
      .debounceTime(Duration(seconds: 1))
      .listen(print); // prints 4

  // Stream.empty().defaultIfEmpty(10).listen(print); // prints 10
  //
  Stream.fromIterable([1, 2, 3, 4])
      .delay(Duration(seconds: 1))
      .listen(print); // [after one second delay] prints 1, 2, 3, 4 immediately
  //
  // Stream.fromIterable([1, 2, 3])
  //     .delayWhen((i) => Rx.timer(null, Duration(seconds: i)))
  //     .listen(print); // [after 1s] prints 1 [after 1s] prints 2 [after 1s] prints 3
  //
  // Stream.fromIterable([1, 2, 3])
  //     .delayWhen(
  //       (i) => Rx.timer(null, Duration(seconds: i)),
  //       listenDelay: Rx.timer(null, Duration(seconds: 2)),
  //     )
  //     .listen(print); // [after 3s] prints 1 [after 1s] prints 2 [after 1s] prints 3

  //
  // Stream.fromIterable([1, 2, 3, 4]).mapTo(10).listen(print); // prints true, true, true, true

  // TimerStream(1, Duration(seconds: 10))
  //     .mergeWith([Stream.fromIterable([2])])
  //     .listen(print); // prints 2, 1

  // Stream.fromIterable([1, 2, 3, 4, 5])
  //     .skipLast(1)
  //     .listen(print); // prints 1, 2

  // MergeStream([
  //   Stream.fromIterable([1]),
  //   TimerStream(2, Duration(minutes: 1)),
  //   Stream.fromIterable([3]),
  // ]).takeUntil(TimerStream(3, Duration(seconds: 10))).listen(print); // prints 1

  // Stream.fromIterable([2, 3, 1, 9, 10, 4, 5, 6, 1, 2, 3]).takeWhileInclusive((i) => i < 4).listen(print); // prints 2, 3, 4

  // Stream.fromIterable([
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     print('======');
  //   })
  // ]).throttle((_) => TimerStream(false, Duration(seconds: 3)));

  // Stream.periodic(Duration(seconds: 1), (int i) => i).listen(print);
  // Stream.periodic(Duration(seconds: 1), (int i) => i).throttle((event) => TimerStream(true, Duration(seconds: 1))).listen(print);

  // print('====${DateTime.now()}');
  // Stream.fromIterable([
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     print('====${timer.toString()}');
  //   })
  // ]).throttleTime(Duration(seconds: 10), leading: false);

  // Stream.fromIterable([1, 2, 3])
  //     .throttleTime(Duration(seconds: 1));

  // Stream.fromIterable([1])
  //     .zipWith(Stream.fromIterable([2]), (one, two) => one + two)
  //     .listen(print); // prints 3
  //
  // Stream.periodic(Duration(milliseconds: 100), (int i) => i)
  //     .windowTime(Duration(milliseconds: 220))
  //     .doOnData((_) => print('next window'))
  //     .flatMap((s) => s)
  //     .listen(print); // prints next window 0, 1, next window 2, 3, ...

  // Stream.fromIterable([1, 2, 3]).min().then(print);
  // Stream.fromIterable([1, 2, 3]).max().then(print);
  //
  // Stream.fromIterable(['short', 'looooooong']).min((a, b) => a.length - b.length).then(print);

  // Stream.fromIterable([1, 2, 3]).scan((acc, curr, i) => acc + curr, 0).listen(print); // prints 1, 3, 6

  // Rx.repeat((repeatIndex) => Stream.value(repeatIndex), 3).listen(print); // prints 1, 1, 1

  // Rx.combineLatest([
  //   Stream.fromIterable(['a']),
  //   Stream.fromIterable(['b']),
  //   Stream.fromIterable(['C', 'D'])
  // ], (values) {
  //     print('>>>>$values');
  //   return values.first;
  // }).listen(print);
  // Rx.combineLatest3(Stream.fromIterable(['a']),
  //     Stream.fromIterable(['b']),
  //     Stream.fromIterable(['C', 'D']), (a, b, c) {
  //       print('>>>>$a $b $c');
  //       return a + b + c;
  //     }).listen(print);
  // Rx.combineLatest([Stream.fromIterable([1,2,3,4,5])], (values) {
  //   print('>>>>$values');
  //   return values.join();
  // }).listen(print);
  // Rx.combineLatest2(Rx.timer(1, Duration(seconds: 1)), Rx.timer(2, Duration(seconds: 1)), (a,b)=>a+b).listen(print);

  // Rx.concat([Stream.fromIterable([1,2,3]),Stream.fromIterable([4,5,6]),Stream.fromIterable([7,8,9]) ]).listen(print); // prints 1, 2, 3
  // Rx.concatEager([
  //   Stream.fromIterable([1, 2, 3]),
  //   Stream.fromIterable([4, 5, 6]),
  //   Stream.fromIterable([7, 8, 9])
  // ]).listen(print);

  // concat示例
  // final streamA = Stream.fromIterable([1, 2, 3]);
  // final streamB = Stream.fromIterable([4, 5, 6]);
  // ConcatStream([streamA, streamB]).listen(print);  // 输出：1, 2, 3, 4, 5, 6

  // concatEager示例
  // final streamC = Stream.fromIterable([7, 8, 9]).delay(Duration(seconds: 2));
  // final streamD = Stream.fromIterable([10, 11, 12]);
  // ConcatEagerStream([streamC, streamD]).listen(print);  // 输出：10, 11, 12, 7, 8, 9

  // Rx.concatEager([Stream.value(1), Rx.timer(2, Duration(seconds: 1)), Stream.value(3)]).listen(print); // prints 1, 2,

  // final deferStream = DeferStream(() => Stream.fromIterable([1, 2, 3]));
  // // 在这个时候，流还没有被创建
  // print('Before subscription');
  // deferStream.listen(print);  // 输出：1, 2, 3
  // // 当我们订阅流的时候，流才被创建并发射事件
  // print('After subscription');

  // final streamA = Stream.fromIterable([1, 2, 3]).delay(Duration(seconds: 2));
  // final streamB = Stream.fromIterable([4, 5, 6]).delay(Duration(seconds: 1));
  // ForkJoinStream.list([streamA, streamB]).listen(print);  // 输出：[3, 6]

  // final callable = () {
  //   return 'Hello, World!';
  // };
  // final stream = FromCallableStream(callable);
  // stream.listen(print);  // 输出：Hello, World!

  // final streamA = Stream.fromIterable([1, 2, 3]).delay(Duration(seconds: 2));
  // final streamB = Stream.fromIterable([4, 5, 6]).delay(Duration(seconds: 1));
  // RaceStream([streamA, streamB]).listen(print);  // 输出：4, 5, 6

  //
  // int attempt = 0;
  // final retryStream = RetryStream(() {
  //   attempt++;
  //   print('==>>$attempt');
  //   if (attempt < 3) {
  //     return Stream<int>.error(Exception('Error'));
  //   } else {
  //     return Stream.fromIterable([1, 2, 3]);
  //   }
  // }, 3);
  // retryStream.listen(print, onError: (e) => print('###'+e.toString()));  // 输出：1, 2, 3

  // final streamA = Stream.fromIterable([1, 2, 3]);
  // final streamB = Stream.fromIterable([1, 2, 3]);
  // SequenceEqualStream(streamA, streamB).listen(print);  // 输出：true

  // final switchLatestStream = SwitchLatestStream<String>(
  //   Stream.fromIterable(<Stream<String>>[
  //     Stream.value('C'),
  //     Stream.value('D'),
  //     Stream.value('E'),
  //     Rx.timer('A', Duration(seconds: 1)),
  //     Stream.value('F'),
  //     Rx.timer('B', Duration(seconds: 2)),
  //   ]),
  // );
  // switchLatestStream.listen(print);

  // final controller = StreamController<Stream<int>>();
  // final switchLatestStream = SwitchLatestStream(controller.stream);
  // switchLatestStream.listen(print);  // 输出：1, 2, 3, 4, 5, 6
  // controller.add(Stream.fromIterable([1, 2, 3]));
  // controller.add(Stream.fromIterable([4, 5, 6]));
  // controller.add(Stream.fromIterable([7,8,9]));


}

