import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Assets.images.icHomeNormal.image(color: Colors.red,colorBlendMode: BlendMode.srcATop),
                  Assets.images.icDiscoveryNormal.image(),
                  Assets.images.icHotNormal.image(),
                  Assets.images.icMineNormal.image(),
                  Assets.images.chip1.image(width: 100),
                  Text(Assets.images.chip1.path),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Assets.lottie.hamburgerArrow.lottie(
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Assets.lottie.alarmClockLottieV440.lottie(
                      fit: BoxFit.contain,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   height: 200,
                  //   child: Assets.lottie.cat.lottie(
                  //     decoder: LottieComposition.decodeGZip, // 5.11.0 才支持
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
