import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_flutter/model/themes.dart';
import 'package:practice_flutter/my_page/my_page.dart';
import 'package:practice_flutter/normal_page/normal_page.dart';
import 'package:practice_flutter/theme_page/theme_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  final pages = [NormalPage(), ThemePage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // 监听
        child: Scaffold(
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '通用语录'),
              BottomNavigationBarItem(icon: Icon(Icons.business), label: '主题'),
              BottomNavigationBarItem(icon: Icon(Icons.school), label: '我的'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapd,
            backgroundColor: Provider
                .of<Themes>(context)
                .themeColor,
          ),
        ),
        onWillPop: () async {
          print("========");
          await showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("提示"),
              content: Text("是否退出App?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          });
          return false;
        });
  }

  void _onItemTapd(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("didChangeAppLifecycleState + $state");
  }

}
