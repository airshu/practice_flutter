import 'package:flutter/material.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomappbar_demo1.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomnavigationbar_demo3.dart';
import 'package:practice_flutter/src/router/app_router.dart';

final Map<String, String> _routes = {
  "BottomNavigationBar基本使用": AppRouter.bottom_navigation_demo1,
  "BottomAppBar基本使用": AppRouter.bottom_app_bar_demo3,
  "BottomAppBar自定义形状": AppRouter.bottom_app_bar_demo2,
};

class BottomNavigationBarMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<BottomNavigationBarMenu> {
  List<String> _menus = _routes.keys.toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text(
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
                      // Navigator.pushNamed(context, '${_menus[index]}');
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
