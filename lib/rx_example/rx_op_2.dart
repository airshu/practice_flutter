import 'package:rxdart/rxdart.dart';

void main() {
  Stream<int> streamA = Stream.fromIterable([1, 2, 3]);
  Stream<int> streamB = Stream.fromIterable([4, 5, 6]);

  streamA.zipWith(streamB, (a, b) => a + b).listen(print); // prints 5, 7, 9
}
