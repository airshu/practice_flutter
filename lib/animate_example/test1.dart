import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/src/base/add_animated_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        extendBody: true,
        body: SafeArea(child: MyApp()),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          currentIndex: 1,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.purple,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          ],
        ),
        floatingActionButton: AddWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

