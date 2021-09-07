import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_flutter/home.dart';
import 'package:practice_flutter/home_page.dart';
import 'package:practice_flutter/model/items.dart';
import 'package:practice_flutter/model/themes.dart';
import 'package:practice_flutter/test_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themes()),
        ChangeNotifierProvider(create: (context) => Items()),
      ],
      child: Consumer<Themes>(
        builder: (context, themes, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.red,
              backgroundColor: Colors.green,
              scaffoldBackgroundColor: themes.themeColor,
              bottomAppBarColor: themes.themeColor,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              // "/": (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
              "/test": (context) => TestPage(title: "Test page"),
              "/home": (context) => HomePage()
            },
            initialRoute: "/home",
          );
        },
      )
    );
  }
}
