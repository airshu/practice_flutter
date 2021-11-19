

import 'package:flutter/material.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomappbar_demo1.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomappbar_demo2.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomnavigationbar_demo3.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomnavigationbar_menu.dart';
import 'package:practice_flutter/src/navigator/navigator_demo1.dart';
import 'package:practice_flutter/src/navigator/navigator_menu.dart';

class AppRouter {
  static const String menu = 'menu';
  // 底部导航栏的使用
  static const String bottom_navigation = 'bottom_navigation';
  static const String bottom_navigation_demo1 = 'bottom_navigation_demo1';
  static const String bottom_navigation_demo2 = 'bottom_navigation_demo2';
  static const String bottom_navigation_demo3 = 'bottom_navigation_demo3';
  static const String bottom_app_bar_demo3 = 'bottom_navigation_demo3';
  static const String bottom_app_bar_demo2 = 'bottom_navigation_demo2';

  // 导航

  static const String navigator = 'navigator';
  static const String navigator_demo1 = 'navigator_demo1';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name}  ===========');
    switch(settings.name) {
      case menu:
        return Right2LeftRouter(child: MenuPage());
      case bottom_navigation_demo1:
        return Right2LeftRouter(child: BottomAppBarDemo1Widget());
      case bottom_app_bar_demo2:
        return Right2LeftRouter(child: BottomAppBarDemo2Widget());
      case bottom_app_bar_demo3:
        return Right2LeftRouter(child: BottomNavigationBarDemo3Widget());
      case bottom_navigation:
        return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return BottomNavigationBarMenu();
        },);

      case navigator:
        return Right2LeftRouter(child: NavigationMenu());
      case navigator_demo1:
        return Right2LeftRouter(child: NavigatorDemo1Widget());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),);
    }
  }
}


final Map<String, String> _routes = {
  "底部导航栏": AppRouter.bottom_navigation,
  "导航测试": AppRouter.navigator,
  "temp": AppRouter.bottom_navigation,
};

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> _menus = _routes.keys.toList();

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
                  color: Colors.grey,
                  child: InkWell(
                    child: Center(child: Text('${_menus[index]}')),
                    onTap: () {
                      Navigator.pushNamed(context, _routes.values.elementAt(index));
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: _menus.length)),
    );
  }
}


class Right2LeftRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;
  Right2LeftRouter({required this.child,this.durationMs=500,this.curve=Curves.fastOutSlowIn})
      :super(
      transitionDuration:Duration(milliseconds: durationMs),
      pageBuilder:(ctx,a1,a2)=>child,
      transitionsBuilder:(ctx,a1,a2, child,) =>
          SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0),).animate(
                CurvedAnimation(parent: a1, curve: curve)),
          ));
}