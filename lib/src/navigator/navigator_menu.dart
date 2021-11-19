import 'package:flutter/material.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomappbar_demo1.dart';
import 'package:practice_flutter/src/bottomnavigationbar/bottomnavigationbar_demo3.dart';
import 'package:practice_flutter/src/router/app_router.dart';

final Map<String, String> _routes = {
  "嵌套导航": AppRouter.navigator_demo1,
};

class NavigationMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
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
          '导航demo',
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
