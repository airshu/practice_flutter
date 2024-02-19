import 'package:flutter_test/flutter_test.dart';

import 'counter.dart';

/// 简单的测试示例
/// flutter test test/demo_test.dart
void main() {
  /// 每个测试前执行
  setUp(() {
    print('setUp');
  });

  setUpAll(() {
    print('setUpAll');
  });

  tearDownAll(() {
    print('tearDownAll');
  });

  /// 每个测试后执行
  tearDown(() {
    print('tearDown');
  });

  // 简单的测试
  test('simple test', () {
    print('simple test');
    expect(
        'foo, bar, baz',
        allOf([
          contains('foo'),
          isNot(startsWith('bar')),
          endsWith('baz'),
        ]));

    expectSync(1 + 2 > 3, false);

    expect(1 + 2, greaterThan(2));

    expect([1, 2, 3, 4].elementAt(2), isNotNull);

    expect(() => int.parse('X'), throwsFormatException);

    expect(Future.value(10), completion(equals(10)));

    String s = 'hello world';
    expect(s.split(' ')[0], 'hello');

    var stream = Stream.fromIterable([1, 2, 3]);

    stream.listen(expectAsync1((number) {
      expect(number, inInclusiveRange(1, 3));
    }, count: 3));


  });

  test('test string', () {
    expect("hello   world", equalsIgnoringWhitespace("hello world"));
    expect("  hello world", equalsIgnoringWhitespace("hello world"));
    expect("hello world  ", equalsIgnoringWhitespace("hello world"));
    // expect("helloworld", equalsIgnoringWhitespace("hello world"));
    // expect("he llo world", equalsIgnoringWhitespace("hello world"));
  });


  test('process emits status messages', () {
    // Dummy data to mimic something that might be emitted by a process.
    var stdoutLines = Stream.fromIterable([
      'Ready.',
      'Loading took 150ms.',
      'Succeeded!'
    ]);

    expect(stdoutLines, emitsInOrder([
      // Values match individual events.
      'Ready.',

      // Matchers also run against individual events.
      startsWith('Loading took'),

      // Stream matchers can be nested. This asserts that one of two events are
      // emitted after the "Loading took" line.
      emitsAnyOf(['Succeeded!', 'Failed!']),

      // By default, more events are allowed after the matcher finishes
      // matching. This asserts instead that the stream emits a done event and
      // nothing else.
      emitsDone
    ]));
  });

  // 组测试
  group('组测试', () {
    print('group test');
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}
