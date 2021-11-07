import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class AddWidget extends StatefulWidget {
  const AddWidget({Key? key}) : super(key: key);

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
    lowerBound: 0.0,
    upperBound: 0.25,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  bool isAnimated = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAnimated) {
          isAnimated = false;
          _controller.reverse();
        } else {
          isAnimated = true;
          _controller.forward();
        }
      },
      child: RotationTransition(
        turns: _animation,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),

          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
