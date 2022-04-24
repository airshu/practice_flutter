import 'package:flutter/material.dart';

void main() {
  runApp(SingleNavigatorPushAndPopApp());
}

class SingleNavigatorPushAndPopApp extends StatelessWidget {
  const SingleNavigatorPushAndPopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '简单的push、pop',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text('View Details'),
          onPressed: () {
            /// 添加新页面
            // Navigator.push(
            //     context,
            //     PageRouteBuilder(
            //       transitionDuration: const Duration(milliseconds: 2000),
            //       pageBuilder: (ctx, animation, secondaryAnimation) {
            //         var curveTween = CurveTween(curve: Curves.easeIn);
            //         return FadeTransition(
            //           opacity: animation.drive(curveTween),
            //           child: DetailScreen(),
            //         );
            //       },
            //     ));
            //
            // Navigator.push(
            //     context,
            //     PageRouteBuilder(
            //       pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
            //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //         const begin = Offset(0.0, 1.0);
            //         const end = Offset.zero;
            //         const curve = Curves.ease;
            //
            //         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            //
            //         return SlideTransition(
            //           position: animation.drive(tween),
            //           child: child,
            //         );
            //       }
            //     ));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('_HomeScreenState  initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('_HomeScreenState didChangeDependencies');
  }

  @override
  void activate() {
    super.activate();
    print('_HomeScreenState activate');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('_HomeScreenState deactivate');
  }
}

class DetailScreen extends StatefulWidget {
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('_DetailScreenState  initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('_DetailScreenState didChangeDependencies');
  }

  @override
  void activate() {
    super.activate();
    print('_DetailScreenState activate');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('_DetailScreenState deactivate');
  }
}
