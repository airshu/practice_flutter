import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: Center(child: CustomClipperWidget()))));
}

class CustomClipperWidget extends StatelessWidget {
  const CustomClipperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget avatar = Container(child: Image.asset("images/logo.png", width: 60.0),color: Colors.red,);

    return Container(
      child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue),child: ClipRect(
        clipper: MyClipper(),
        child: avatar,
      ),),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

