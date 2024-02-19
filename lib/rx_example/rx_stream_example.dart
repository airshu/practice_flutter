import 'package:rxdart/rxdart.dart';

void main() {
  // CombineLatestStream.list([
  //   Stream.fromIterable(['a']),
  //   Stream.fromIterable(['b']),
  //   Stream.fromIterable(['C', 'D'])
  // ]).listen((event) {
  //   print('combineLatest>>>>   $event');
  // });
  //
  // CombineLatestStream([
  //   Stream.fromIterable(['a']),
  //   Stream.fromIterable(['b']),
  //   Stream.fromIterable(['C', 'D'])
  // ], (values) => values.last).listen(print); //prints 'C', 'D'

  // CombineLatestStream.combine2(
  //   Stream.fromIterable([1]),
  //   Stream.fromIterable([2, 3]),
  //   (a, b) => a + b,
  // ).listen(print); // prints 3, 4

  // ConcatStream([
  //   Stream.fromIterable([1]),
  //   TimerStream(2, Duration(seconds: 1)),
  //   Stream.fromIterable([3])
  // ]).listen(print); // prints 1, 2, 3

  // ConcatEagerStream([
  //   Stream.fromIterable([1]),
  //   TimerStream(2, Duration(seconds: 1)),
  //   Stream.fromIterable([3])
  // ]).listen(print); // prints 1, 2, 3
  //
  //
  // DeferStream(() => Stream.value(1)).listen(print); //prints 1

  // MergeStream([
  //   TimerStream(1, Duration(seconds: 10)),
  //   Stream.fromIterable([2])
  // ]).listen(print); // prints 2, 1

  // RepeatStream((int repeatCount) => Stream.value('repeat index: $repeatCount'), 3).listen((i) => print(i)); // Pri

  // RetryStream(() => Stream.value(1)).listen((i) => print(i)); // Prints 1

  // RetryStream(
  //   () => Stream.value(1).concatWith([Stream<int>.error(Error())]),
  //   1,
  // ).listen(
  //   print,
  //   onError: (Object e, StackTrace s) => print(e),
  // ); // Prints 1, 1, Instance of 'Error', Instance of 'Error'

  // ZipStream(
  //   [
  //     Stream.fromIterable(['A']),
  //     Stream.fromIterable(['B']),
  //     Stream.fromIterable(['C', 'D']),
  //   ],
  //   (values) => values.join(),
  // ).listen(print); // prints 'ABC'

  ZipStream.zip2(
    Stream.fromIterable(['A']),
    Stream.fromIterable(['B', 'C']),
    (a, b) => a + b,
  ).listen(print); // prints 'AB'
}
