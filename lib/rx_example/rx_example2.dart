import 'package:rxdart/rxdart.dart';

void main() {
  test1();
}

void test1() {
  Stream.fromIterable([1, 2, 3, 4, 5]).map((event) => ++event).toList().then((value) {
    print('map>>>$value');
  });

  Stream.fromIterable([
    {
      'item': [1, 2, 3, 4]
    },
    {
      'item': [5, 6, 7, 8]
    }
  ]).flatMap((e) => Stream.fromIterable(e['item']?.toList() ?? [])).toList().then((value) {
    print('flatMap>>>>   $value');
  });

  Stream.fromIterable([1, 2, 3, 4]).expand((element) => [element, element + 100]).toList().then((value) {
    print('expand>>>>   $value');
  });

  Stream.fromIterable([1, 2, 3, 4])
      .mergeWith([
        Stream.fromIterable([5, 6]),
        Stream.fromIterable([7, 8])
      ])
      .toList()
      .then((value) {
        print('mergeWith>>>>   $value');
      });
}
