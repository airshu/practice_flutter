import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // 点击的效果，fixed固定icon，shifting移动icon
          onTap: (value) {
            setState(() {
              _currentIndex = value;//点击切换tab
            });
          },
          items: [
            BottomNavigationBarItem(label: '首页', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '书籍', icon: Icon(Icons.book)),
            BottomNavigationBarItem(label: '我的', icon: Icon(Icons.perm_identity)),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){}, ),
      ),
    );
  }
}
