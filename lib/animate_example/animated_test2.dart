import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
/// 居中缩放效果
/// https://stackoverflow.com/questions/44990714/flutter-effect-of-flip-card
class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyCustomCard extends StatelessWidget {
  MyCustomCard({required this.colors });

  final MaterialColor colors;

  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      height: 144.0,
      width: 360.0,
      decoration: BoxDecoration(
        color: colors.shade50,
        border: Border.all(color: Color(0xFF9E9E9E)),
      ),
      child: FlutterLogo(size: 100.0, textColor: colors),
    );
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontScale;
  late Animation<double> _backScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.flip_to_back),
        onPressed: () {
          setState(() {
            if (_controller.isCompleted || _controller.velocity > 0)
              _controller.reverse();
            else
              _controller.forward();
          });
        },
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              child: MyCustomCard(colors: Colors.orange),
              animation: _backScale,
              builder: (BuildContext context, Widget? child) {
                final Matrix4 transform = Matrix4.identity()
                  ..scale(1.0, _backScale.value, 1.0);
                return Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
            AnimatedBuilder(
              child: MyCustomCard(colors: Colors.blue),
              animation: _frontScale,
              builder: (BuildContext context, Widget? child) {
                final Matrix4 transform = Matrix4.identity()
                  ..scale(1.0, _frontScale.value, 1.0);
                return Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}