import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  //1.创建绘制记录器和Canvas
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);
  //2.在指定位置区域绘制。
  var rect = Rect.fromLTWH(30, 200, 300,300 );

  Paint paint = Paint();

  canvas.drawRect(rect, paint);
  // canvas.drawChessboard(canvas,rect); //画棋盘
  // drawPieces(canvas,rect);//画棋子
  //3.创建layer，将绘制的产物保存在layer中
  var pictureLayer = PictureLayer(rect);
  //recorder.endRecording()获取绘制产物。
  pictureLayer.picture = recorder.endRecording();
  var rootLayer = OffsetLayer();
  rootLayer.append(pictureLayer);
  //4.上屏，将绘制的内容显示在屏幕上。
  final SceneBuilder builder = SceneBuilder();
  final Scene scene = rootLayer.buildScene(builder);
  window.render(scene);


}

class ChessWidget extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderChess();
  }

}

class RenderChess extends RenderBox {
  @override
  void performLayout() {
   size = constraints.constrain(constraints.isTight ? Size.infinite : Size(150, 150),);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    Paint paint = Paint();
    context.canvas.drawRect(rect, paint);
  }
}
