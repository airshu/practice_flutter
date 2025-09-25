import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/gen/assets.gen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  PageController pageController = PageController();

  final name1 = 'nam1';

  final name2 = 'name2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Row(
              children: [
                Column(
                  children: [
                    CupertinoButton(
                        child: Text('menu1'),
                        onPressed: () {
                          pageController.jumpToPage(0);
                        }),
                    CupertinoButton(
                        child: Text('menu2'),
                        onPressed: () {
                          pageController.jumpToPage(1);
                        }),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: PageView(
                      controller: pageController,
                      children: [
                        TestPage(
                          pageName: 'test1',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  TestPage({Key? key, required this.pageName}) : super(key: key);

  final String pageName;

  static const String opportunityDetail = '/opportunity/main/detailV2'; // 商机客户详情V2
  static const String opportunityMain = '/opportunity/main';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TestPage1(
      pageName: 'aaa',
    ));
  }
}

class TestPage1 extends StatelessWidget {
  TestPage1({Key? key, required this.pageName}) : super(key: key);

  final String pageName;

  @override
  Widget build(BuildContext context) {
    print('Testpage1  build====>>>>  $pageName');
    return Container(
      child: Center(
        child: Column(
          children: [
            Assets.images.icHomeNormal.image(),
            Image.asset(Assets.images.icHotSelected.path),
            ElevatedButton(
              child: const Text('Pop!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text(
                '>>>>  $pageName',
              ),
              onPressed: () {
                var page = TestPage1(pageName: '$pageName  1232');
                // Get.global(10001).currentState?.push(newCommonPageRouteBuilder(page));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return page;
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static PageRouteBuilder newCommonPageRouteBuilder(Widget widget,
      {Widget Function(BuildContext ctx, Animation<double> one, Animation<double> two, Widget child)? transition}) {
    return PageRouteBuilder(
        pageBuilder: (ctx, one, two) => widget, transitionsBuilder: transition ?? slideTransitionRTL);
  }

  static SlideTransition slideTransitionRTL(ctx, one, two, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(one),
      child: child,
    );
  }
}
