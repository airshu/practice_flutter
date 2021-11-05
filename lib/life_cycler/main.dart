

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/life_cycler/applifecycle_test1.dart';

void main() {
  runApp(_MyApp());
}



class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '生命周期测试',
      routes: _routes,
      initialRoute: "menu",
    );
  }
}

final Map<String, WidgetBuilder> _routes = {
  "menu": (context) => _MenuPage(),
  "lifecycle": (context) => ApplifeCycleTestWidgdet(),

};

class _MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<_MenuPage> {
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
