import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:practice_flutter/home.dart';
import 'package:practice_flutter/test_page/anim_test_page.dart';
import 'package:practice_flutter/test_page/container_test_page.dart';
import 'package:practice_flutter/test_page/inherited_test_page.dart';
import 'package:practice_flutter/test_page/refresh_test_page.dart';
import 'package:practice_flutter/test_page/shopping_page.dart';
import 'package:practice_flutter/test_page/state1_test_page.dart';
import 'package:practice_flutter/test_page/test_page.dart';
import 'package:practice_flutter/test_page/text_page.dart';
import 'package:practice_flutter/test_page/widget_lifecycle_page.dart';
import 'package:practice_flutter/test_page/widget_page.dart';

void main() {
  // 重写异常方法，可用于上报
  FlutterError.onError = (FlutterErrorDetails details) {
    // stderr.writeln('出错啦！！！！！！!!!!!');
    FlutterError.dumpErrorToConsole(details);
  };

  // 隔离异常监听
  Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
    print('Isolate error ');
  }).sendPort);

  // Exception, 未被 Flutter 捕获的错误
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }, (Object error, StackTrace stack){
    stderr.writeln('${error.toString()} ===\n====  ${stack.toString()}'  );

  });


  ///这是设置状态栏的图标和字体的颜色
  ///Brightness.light  一般都是显示为白色
  ///Brightness.dark 一般都是显示为黑色
  // SystemUiOverlayStyle style = const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark);
  // SystemChrome.setSystemUIOverlayStyle(style);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      // scaffoldBackgroundColor: themes.themeColor,
      // bottomAppBarColor: themes.themeColor,
      // ),
      // debugShowCheckedModeBanner: false,
      routes: _routes,
      initialRoute: "menu",
    );
  }
}

final Map<String, WidgetBuilder> _routes = {
  "menu": (context) => MenuPage(),
  "test": (context) => CustomerStatefulWidget('_name'),
  "home": (context) => HomePage(),
  "text": (context) => TextPage(),
  "shopping": (context) => ShoppingPage(),
  "widget": (context) => WidgetPage(),
  "container": (context) => ContainerTestPage(),
  "widget_lifecycle": (context) => WidgetLifeCyclePage(),
  "anim_test": (context) => AnimTestPage(),
  "pull_to_refresh": (context) => PullToRefreshWidget(),
  "ParentWidgetC": (context) => ParentWidgetC(),
  "MyTree": (context) => InheritedWidgetTestRoute(),
  // 'GetX': (context) => GetXExamplePage(),
};

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> _menus = _routes.keys.toList().sublist(1);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '目录',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.green,
                  child: GestureDetector(
                    child: Center(child: Text('${_menus[index]}')),
                    onTap: () {
                      Navigator.pushNamed(context, '${_menus[index]}');
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: _menus.length)),
    );
  }
}

