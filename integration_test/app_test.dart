import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

/// UI测试示例

void main() async {
  // 确保Flutter框架已经初始化完成
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // enableFlutterDriverExtension();

  // final dio = Dio();
  // final dioAdapter = DioAdapter(dio: dio);
  // dio.httpClientAdapter = dioAdapter;



  // test('description', () async {
  //   String url = 'http://baidu.com';
  //   dioAdapter.onGet(url, (server) {
  //     server.reply(200, {'message': 'success'});
  //   });
  //   final response = await dio.get(url);
  //   print(response.data);
  // });

  testWidgets('test app', (WidgetTester tester) async {

    // await tester.pumpWidget(MyApp());

    await tester.pumpAndSettle();

    await tester.pump();

    expect(find.byType(Container), findsWidgets);

    final item = find.text('menu1');
    print('======$item');
    expect(item, findsOneWidget);


    await tester.tap(find.byType(CupertinoButton).first);

    await tester.pumpAndSettle();

    // expect(find.text('menu'), findsOneWidget);

    // expect(MyApp(), isA<StatelessWidget>());

  });

  // group('Test ', () {
  //   t.FlutterDriver? driver;
  //
  //   // 连接Flutter Driver并初始化
  //   setUpAll(() async {
  //     driver = await t.FlutterDriver.connect();
  //   });
  //
  //   // 关闭连接
  //   tearDownAll(() async {
  //     if (driver != null) {
  //       driver!.close();
  //     }
  //   });
  //
  //   // 测试用例
  //   test('test', () async {
  //
  //     // 等待页面加载完成
  //     await driver!.waitFor(t.find.byType('Scaffold'));
  //
  //     // 点击按钮
  //     // await driver!.tap(find.byType(IconButton));
  //
  //   });
  // });
}
