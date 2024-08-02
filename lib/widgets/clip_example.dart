import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(ClipWidget());
}

class ClipWidget extends StatefulWidget {
  const ClipWidget({super.key});

  @override
  State<ClipWidget> createState() => _ClipWidgetState();
}

class _ClipWidgetState extends State<ClipWidget> {
  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset('assets/images/111.jpeg', width: 100, height: 100,);
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            Container(
                color: Colors.pink,
                child: image),
            Container(
              color: Colors.grey,
                child: ClipOval(child: image)),
            ClipRRect(
              child: image,
              borderRadius: BorderRadius.circular(50),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  child: Align(
                    child: image,
                    // alignment: Alignment.center,
                    widthFactor: 0.8,
                    heightFactor: 0.5,
                  ),
                ),
                Text("你好世界", style: TextStyle(color: Colors.green),)
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Container(
                    color: Colors.blue,
                    child: Align(
                      child: image,
                      // alignment: Alignment.center,
                      // widthFactor: 0.5,
                      heightFactor: 0.5,
                    ),
                  ),
                ),
                Text("你好世界", style: TextStyle(color: Colors.green),)
              ],
            ),
          ],

        ),
      ),
    );
  }
}
