import 'package:flutter/material.dart';
import 'package:practice_flutter/route/navigator2_nested.dart';
import 'package:practice_flutter/route/navigator2_simple_test.dart';
import 'package:practice_flutter/route/overlay_dragger.dart';
import 'package:practice_flutter/route/single_navigator_push_and_pop.dart';

import 'named_navigator.dart';
import 'navigator2_test.dart';
import 'ongenerate_navigator.dart';

main() {
  runApp(NavigatorMainApp());
}

class NavigatorMainApp extends StatelessWidget {
  NavigatorMainApp({Key? key}) : super(key: key);

  final routes = [
    {'SingleNavigatorPushAndPopApp': SingleNavigatorPushAndPopApp()},
    {'SingleNavigatorApp': SingleNavigatorApp()},
    {'NestedRouterApp': NestedRouterApp()},
    {'Navigator2BooksApp': Navigator2BooksApp()},
    {'NavigatorOnGenerateApp': NavigatorOnGenerateApp()},
    {'NamedRouteApp': NamedRouteApp()},
    {'拖拽': OverlayDraggerWidget()},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(routes.elementAt(index).keys.toString()),
              height: 40,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => routes.elementAt(index).values.elementAt(0),
                  ));
            },
          );
        },
        itemCount: routes.length,
      ),
    ));
  }
}
