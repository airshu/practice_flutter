import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  ui.Image;
  runApp(MaterialApp(
    home: Scaffold(
      body: App(),
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  ui.Image? image;

  @override
  void initState() {
    () async {
      image = await load('assets/images/111.jpeg');
      setState(() {

      });
    }();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: const Size(300, 300),
        painter: image != null ? MyPainter(image!) : null,
      ),
    );
  }


  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: 100, targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}

class MyPainter extends CustomPainter {



  @override
  void paint(Canvas canvas, Size size) async {
    /// 绘制文本
    // const textStyle = TextStyle(color: Colors.black, fontSize: 24);
    // const textSpan = TextSpan(text: 'Hello, World', style: textStyle);
    // final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    // textPainter.layout(minWidth: 0, maxWidth: size.width);
    // const offset = Offset(50, 100);
    // textPainter.paint(canvas, offset);


    canvas.drawImage(image!, Offset.zero, Paint());
  }

  ui.Image? image;





  /// 描述绘制流程
  void test(Canvas canvas, Size size) {

    // 第一步
    final paragraphStyle = ParagraphStyle(
      // 字体方向，有些国家语言是从右往左排版的
        textDirection: TextDirection.ltr,
        // 字体对齐方式
        textAlign: TextAlign.justify,
        fontSize: 14,
        maxLines: 2,
        // 字体超出大小时显示的提示
        ellipsis: '...',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        height: 5,
        // 当我们设置[TextStyle.height]时 这个高度是否应用到字体顶部和底部
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: true, applyHeightToLastDescent: true));
// 第二步 与第三步
    final paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..addText('ParagraphBuilder类接收一个参数，是一个ParagraphStyle类，用于设置字体基本样式，例如字体方向、对齐方向、字体粗细等，下面我们分几个步骤来绘制文字');
// 第四步
    var paragraph = paragraphBuilder.build();
// 第五步
    paragraph.layout(ParagraphConstraints(width: 300));
// 画一个辅助矩形（可以通过paragraph.width和paragraph.height来获取绘制文字的宽高）
    canvas.drawRect(Rect.fromLTRB(50, 50, 50 + paragraph.width, 50 + paragraph.height),
        Paint()..color = Colors.red.withOpacity(0.5));
// 第六步
    canvas.drawParagraph(paragraph, Offset(50, 50));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  MyPainter(this.image);
}
