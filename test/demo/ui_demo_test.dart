import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

  //测试无状态UI
  testWidgets('test build context', (WidgetTester widgetTester) async {
    print('widget test');
    //触发渲染
    await widgetTester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Text('test test'),
                ElevatedButton(
                  onPressed: () {
                    print('=======Login==========');
                  },
                  child: Text('Login'),
                )
              ],
            ),
          );
        },
      ),
    ));

    expect(find.text('test test'), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    //点击某个类型的按钮
    widgetTester.tap(find.byType(ElevatedButton));
  });

  //测试点击后的UI变化
  testWidgets('test statful widget', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Builder(
      builder: (context) {
        int count = 0;
        return Material(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                child: Column(
                  children: [
                    Text('count: $count'),
                    TextField(),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: Text('Add'))
                  ],
                ),
              );
            },
          ),
        );
      },
    )));
    await widgetTester.tap(find.byType(ElevatedButton));
    await Future.microtask(widgetTester.pump); //等待下一帧
    expect(find.text('count: 1'), findsOneWidget);
    await widgetTester.enterText(find.byType(TextField), 'AAAA');//输入文本
    await widgetTester.pump();
    expect(find.text('AAAA'), findsOneWidget);
  });


}
