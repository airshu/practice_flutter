import 'package:flutter/material.dart';
import 'package:practice_flutter/src/base/add_animated_widget.dart';
import 'dart:math' as math;

import 'package:practice_flutter/utils/eventbus_util.dart';

class BottomAppBarDemo2Widget extends StatefulWidget {
  @override
  _BottomAppBarDemo2WidgetState createState() => _BottomAppBarDemo2WidgetState();
}

class _BottomAppBarDemo2WidgetState extends State<BottomAppBarDemo2Widget> {
  UniqueKey addKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义形状'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        itemCount: 100,
      ),
      floatingActionButton: AddWidget(
        key: addKey,
        clicked: () async {
          var result = await showDialog(
              context: context,
              builder: (context) {
                return MenuWidget();
              },
              barrierColor: Colors.transparent);
          // print('======  $result');
          EventBusUtil.eventBus.fire(AddWidgetEvent());
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return MenuWidget();
          // },));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.white,
        // shape: AutomaticNotchedShape(RoundedRectangleBorder(),StadiumBorder(side: BorderSide())), //shape of notch
        shape: MyCircularNotchedRectangle(),
        // shape: CircularNotchedRectangle(),
        elevation: 10,
        clipBehavior: Clip.none,
        // shape: CustomNotchedShape(context),
        notchMargin: 5,
        //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.print,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        // color: Colors.grey,
        child: Stack(
          children: [
            Positioned(
              child: AnimatedBuilderTestWidget(
                child: Icon(Icons.camera_alt),
              ),
              left: w / 2 - 60,
              bottom: 60,
            ),
            Positioned(
              child: AnimatedBuilderTestWidget(
                child: Icon(Icons.animation),
                direction: Axis.vertical,
              ),
              left: w / 2 - 10,
              bottom: 100,
            ),
            Positioned(
              child: AnimatedBuilderTestWidget(
                child: GestureDetector(
                  onTap: () {
                    print('================');
                    Navigator.pop(context, 'hahah');
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              left: w / 2 + 30,
              bottom: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBuilderTestWidget extends StatefulWidget {
  AnimatedBuilderTestWidget({Key? key, required this.child, this.direction = Axis.horizontal}) : super(key: key);

  Widget child;

  Axis direction;

  @override
  _AnimatedBuilderTeState createState() => _AnimatedBuilderTeState();
}

class _AnimatedBuilderTeState extends State<AnimatedBuilderTestWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child, // 性能优化，减少重绘
      animation: _controller,
      builder: (context, child) {
        final Matrix4 transform = Matrix4.identity();
        if (widget.direction == Axis.horizontal) {
          transform.scale(_controller.value, 1.0, 1.0);
        } else {
          transform.scale(1.0, _controller.value, 1.0);
        }
        return Transform(
          transform: transform,
          alignment: FractionalOffset.center,
          child: Container(
            // width: 30,
            // width: 30 * _controller.value,
            // height: 30 * _controller.value,
            height: 30,
            // color: Colors.blue,
            // alignment: Alignment.center,
            // transform: Matrix4.identity()..scale(_controller.value, 1.0, 1.0),//Matrix4.diagonal3Values(1.0,_controller.value, 1.0),
            child: child,
          ),
        );
      },
    );
  }
}

class CustomNotchedShape extends NotchedShape {
  final BuildContext context;

  const CustomNotchedShape(this.context);

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    const radius = 40.0;
    const lx = 20.0;
    const ly = 8;
    const bx = 10.0;
    const by = 20.0;
    var x = (MediaQuery.of(context).size.width - radius) / 2 - lx;
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(x, host.top)
      ..quadraticBezierTo(x + bx, host.top, x += lx, host.top - ly)
      ..quadraticBezierTo(x + radius / 2, host.top - by, x += radius, host.top - ly)
      ..quadraticBezierTo((x += lx) - bx, host.top, x, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom);
  }
}

/// 绘制凹槽
class MyCircularNotchedRectangle extends NotchedShape {
  /// Creates a [CircularNotchedRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  const MyCircularNotchedRectangle();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);
    print('========================');
    final double notchRadius = guest.width / 2.0;

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null, growable: false);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] = p[i]! + guest.center;

    print(host);
    // print(p[1]!.dx);
    // print(p[1]!.dy);
    // print(p[2]!.dx);
    // print(p[2]!.dy);
    print(p[3]);
    print(notchRadius);
    print('========================>');

    // return Path()
    //   ..moveTo(host.left, host.top)
    //   ..lineTo(p[0]!.dx, p[0]!.dy)
    //   ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
    //   ..arcToPoint(
    //     p[3]!,
    //     radius: Radius.circular(notchRadius),
    //     clockwise: false,
    //   )
    //   ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
    //   ..lineTo(host.right, host.top)
    //   ..lineTo(host.right, host.bottom)
    //   ..lineTo(host.left, host.bottom)
    //   ..close();

    Offset offset = Offset(p[3]!.dx, 0);
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx + 16, p[0]!.dy)
      // ..lineTo(p[0]!.dx, p[0]!.dy-30)`
      // ..lineTo(p[0]!.dx+100, p[0]!.dy-30)
      // ..lineTo(p[0]!.dx+100, p[0]!.dy)`
      // ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        offset,
        radius: Radius.circular(2),
        clockwise: true,
        // largeArc:true,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom);
  }
}
