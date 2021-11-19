import 'package:flutter/material.dart';

/// 测试不同的跳转类型
/// 嵌套跳转

class NavigatorDemo1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demos',
      routes: {
        '/': (BuildContext context) => Home(),
        '/login': (BuildContext context) => Profile(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeNavigator(),
    // PlaceholderWidget('Home'),
    // PlaceholderWidget('Profile'),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => HomePage();
            break;
          case 'demo1':
            builder = (BuildContext context) => Profile();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('demo1'),
          onPressed: () {
            Navigator.of(context).pushNamed('demo1'); // 内部跳转
          },
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log Out'),
          onPressed: () {
            Navigator.of(context).pushNamed('/login'); // 跳转到独立的页面
          },
        ),
      ),
    );
  }
}
