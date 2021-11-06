import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyScaffoldWidget()));
}

class MyScaffoldWidget extends StatelessWidget {
  const MyScaffoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: 1,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(icon: Icon(Icons.remove), label: ''),
          BottomNavigationBarItem(
              icon: Container(
                child: Icon(Icons.school),
                color: Colors.yellow,
              ),
              label: 'School'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School', backgroundColor: Colors.red),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
