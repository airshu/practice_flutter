import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(body: SafeArea(child: WaterMask())),
  ));
}

///
class WaterMask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: wChild(1, Colors.white, 200)),

        WaterMark(
          // painter: TextWaterMarkPainter(text: 'wendux', rotate: -20),
        ),
      ],
    );

  }

  Widget wChild(int index, color, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }

}

class WaterMark extends StatelessWidget {
  const WaterMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform(
        transform: Matrix4.translationValues(30.0, 0.0, 0.0),
        child: Container(
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), itemBuilder: (context, index) {
            return Transform(
              transform: Matrix4.rotationZ(-0.5),
              child: Text('haha', style: TextStyle(
                color: Colors.grey.withAlpha(100),
              ),),
            );
          },),
        ),
      ),
    );
  }
}
