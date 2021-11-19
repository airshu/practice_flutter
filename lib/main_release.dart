
import 'package:flutter/material.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomnavigationbar_menu.dart';
import 'package:practice_flutter/src/router/app_router.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter组件实例',
      initialRoute: "menu",
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

