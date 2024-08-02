import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

void main() {
  runApp(MaterialApp(
    home: CustomPaintExample(),
  ));
}

class CustomPaintExample extends StatefulWidget {
  const CustomPaintExample({super.key});

  @override
  State<CustomPaintExample> createState() => _CustomPaintExampleState();
}

class _CustomPaintExampleState extends State<CustomPaintExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPaint Example'),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      color: Colors.grey[300],
      width: 400,
      height: double.infinity,
      child: CustomPaint(
        foregroundPainter: CirclePainter(
          outerCircleRadiusProgress: 0.5,
          innerCircleRadiusProgress: 0.3,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
      {required this.outerCircleRadiusProgress,
      required this.innerCircleRadiusProgress,
      this.circleColor = const CircleColor(start: Color(0xFFFF5722), end: Color(0xFFFFC107))}) {
    //circlePaint..style = PaintingStyle.fill;
    _circlePaint.style = PaintingStyle.stroke;
    //maskPaint..blendMode = BlendMode.clear;
  }

  final Paint _circlePaint = Paint();

  //Paint maskPaint = new Paint();

  final double outerCircleRadiusProgress;
  final double innerCircleRadiusProgress;
  final CircleColor circleColor;

  drawPath(Canvas canvas, Size size) {
    Paint newPaint(Color color) {
      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;
      return paint;
    }

    Path generatePath(double x, double y) {
      Path path = Path();
      path.moveTo(x, y);
      // path.lineTo(x + 100, y + 100);
      // path.relativeLineTo(x + 100, y + 100);
      path.lineTo(x + 100, y + 100);
      path.lineTo(x + 150, y + 80);
      path.lineTo(x + 100, y + 200);
      path.lineTo(x, y + 100);
      return path;
    }

    canvas.drawPath(generatePath(100, 100), newPaint(Colors.red));
    // canvas.save();
    // canvas.rotate(10 * pi / 180);
    // canvas.drawPath(generatePath(100, 150), newPaint(Colors.blue));
    // canvas.restore();
    // canvas.drawPath(generatePath(100, 500), newPaint(Colors.yellow));
  }

  ///    pointMode: 设置点、线
  ///         PointMode.points 设置点
  ///         PointMode.lines 两个两个点之间连接，如果传入的points是奇数，最后一个点将会被忽略
  ///         PointMode.polygon 将所有点连接起来
  ///     points: 一个Offset数组，可以画多个点
  drawPoints(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 20;

    canvas.drawPoints(
        PointMode.points,
        [
          Offset(100, 100),
          Offset(250, 180),
          Offset(200, 300),
        ],
        paint);
    // 将端点设置为圆形
    paint.strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, [Offset(100, 200)], paint);
  }

  /// 画直线
  drawLine(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 20;
    canvas.drawLine(Offset(100, 100), Offset(250, 180), paint);
    //PointMode.lines可以达到同样的效果
    // canvas.drawPoints(
    //     PointMode.lines,
    //     [
    //       Offset(100, 100),
    //       Offset(250, 180),
    //     ],
    //     paint);
  }

  drawRect(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 20;

    // Rect.fromLTRB 参数：
    // left: 矩形左边距离画布左边距离
    // top: 矩形顶部距离画布顶部距离
    // right: 矩形右边距离画布左边边距离
    // bottom: 矩形底部距离画布顶部距离
    // canvas.drawRect(Rect.fromLTRB(50, 50, 350, 350), paint);
    // canvas.drawRect(Rect.fromCenter(center: Offset(40, 20), width: 20, height: 30), paint);
    // canvas.drawRect(Rect.fromCircle(center: Offset(100, 120), radius: 50), paint);
    canvas.drawRect(Rect.fromPoints(Offset(100, 120), Offset(130, 140)), paint);
  }

  drawOval(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 20;
    Rect pRect = Rect.fromLTRB(50, 150, 400, 350);
// 为了区别，先绘制一个矩形区域
    canvas.drawRect(pRect, paint);
    paint.color = Colors.yellow;
// 绘制椭圆
    canvas.drawOval(pRect, paint);
  }

  drawArc(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.pink;
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100);
    canvas.save();
    canvas.drawRect(rect, Paint()..color = Colors.blue);
    canvas.restore();
    canvas.drawArc(rect, 90 * (pi / 180), 90 * (pi / 180), false, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawPoints(canvas, size);
    drawLine(canvas, size);
    drawRect(canvas, size);
    drawOval(canvas, size);
    drawArc(canvas, size);
    drawPath(canvas, size);
    drawCircle(canvas, size);
  }

  drawCircle(Canvas canvas, Size size) {

    final double center = size.width * 0.5;
    _updateCircleColor();
    // canvas.saveLayer(Offset.zero & size, Paint());
    // canvas.drawCircle(Offset(center, center),
    //     outerCircleRadiusProgress * center, circlePaint);
    // canvas.drawCircle(Offset(center, center),
    //     innerCircleRadiusProgress * center + 1, maskPaint);
    // canvas.restore();
    //flutter web don't support BlendMode.clear.
    final double strokeWidth = outerCircleRadiusProgress * center -
        (innerCircleRadiusProgress * center);
    if (strokeWidth > 0.0) {
      _circlePaint.strokeWidth = strokeWidth;
      canvas.drawCircle(Offset(center, center),
          outerCircleRadiusProgress * center, _circlePaint);
    }
  }

  double clamp(double value, double low, double high) {
    return min(max(value, low), high);
  }

  double mapValueFromRangeToRange(double value, double fromLow, double fromHigh, double toLow, double toHigh) {
    return toLow + ((value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow));
  }

  void _updateCircleColor() {
    double colorProgress = clamp(outerCircleRadiusProgress, 0.5, 1.0);
    colorProgress = mapValueFromRangeToRange(colorProgress, 0.5, 1.0, 0.0, 1.0);
    _circlePaint.color = Color.lerp(circleColor.start, circleColor.end, colorProgress)!;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate.runtimeType != runtimeType) {
      return true;
    }

    return oldDelegate is CirclePainter &&
        (oldDelegate.outerCircleRadiusProgress != outerCircleRadiusProgress ||
            oldDelegate.innerCircleRadiusProgress != innerCircleRadiusProgress ||
            oldDelegate.circleColor.start != circleColor.start ||
            oldDelegate.circleColor.end != circleColor.end);
  }
}
