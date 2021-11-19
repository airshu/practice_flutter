import 'package:flutter/material.dart';
import 'dart:math';

const owl_url = 'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedOpacity(
        onEnd: () {
          print('onEnd');
        },
        opacity: opacity,
        duration: Duration(seconds: 1),
        child: Image.network(owl_url),
      ),
      TextButton(
        child: Text(
          'Show details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () {
          setState(() {
            opacity = (opacity - 1).abs();
          });

        },
      ),
      Container(
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FadeInDemo(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MyApp(),
  );
}
