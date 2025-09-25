import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/gen/assets.gen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Assets.images.icHomeNormal.image(color: Colors.red,colorBlendMode: BlendMode.srcATop),
                Assets.images.icDiscoveryNormal.image(),
                Assets.images.icHotNormal.image(),
                Assets.images.icMineNormal.image(),
                Assets.images.chip1.image(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
