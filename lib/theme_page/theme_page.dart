import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/model/themes.dart';
import 'package:provider/provider.dart';

/**
 * 主题设置
 */
class ThemePage extends StatefulWidget {
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  int _counter = 0;

  String _colorKey = "";

  Map<String, Color> themeColorMap = {
    'gray': Colors.grey,
    'blue': Colors.blue,
    'blueAccent': Colors.blueAccent,
    'cyan': Colors.cyan,
    'deepPurple': Colors.purple,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'deepOrange': Colors.orange,
    'green': Colors.green,
    'indigo': Colors.indigo,
    'indigoAccent': Colors.indigoAccent,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'red': Colors.red,
    'teal': Colors.teal,
    'black': Colors.black,
  };

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _colorKey = SpUtil.getString('key_theme_color', defValue: 'blue')!;
    // 设置初始化主题颜色
    // Provider.of<Themes>(context, listen: false).setTheme(_colorKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主题设置"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ExpansionTile(
              title: Text(''),
              initiallyExpanded: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: themeColorMap.keys.map((key) {
                      Color? value = themeColorMap[key];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _colorKey = key;
                          });
                          SpUtil.putString('key_theme_color', key);
                          Provider.of<Themes>(context, listen: false)
                              .setTheme(value!);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          color: value,
                          child: _colorKey == key
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
