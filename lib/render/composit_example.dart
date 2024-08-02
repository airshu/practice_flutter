import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  test1();
  // test2();
}

void test1() {
  PictureRecorder recorder = PictureRecorder();
  // 初始化 Canvas 时，传入 PictureRecorder 实例
  // 用于记录发生在该 canvas 上的所有操作
  //
  Canvas canvas = Canvas(recorder);
  Paint circlePaint= Paint();
  circlePaint.color = Colors.blueAccent;
  // 调用 Canvas 的绘制接口，画一个圆形
  canvas.drawCircle(Offset(400, 400), 300, circlePaint);
  // 绘制结束，生成Picture
  Picture picture = recorder.endRecording();


  PictureRecorder recorder2 = PictureRecorder();//画板记录器
  Canvas canvas2 = Canvas(recorder2);//画板
  canvas2.drawRect(Rect.fromLTRB(0, 0, 200, 200), Paint()..color = Colors.yellow);//在画板上绘制
  Picture picture2 = recorder2.endRecording();//完成记录，返回照片

  SceneBuilder sceneBuilder = SceneBuilder();//场景构建器
  sceneBuilder.pushOffset(0, 0);
  // 将 picture 送入 SceneBuilder
  sceneBuilder.addPicture(Offset(0, 0), picture);
  sceneBuilder.addPicture(Offset(100, 100), picture2);//将照片添加到场景中
  sceneBuilder.pop();

  // 生成 Scene
  Scene scene = sceneBuilder.build();//返回场景
  window.onDrawFrame = () {
    // 将 scene 送入 Engine 层进行渲染显示
    window.render(scene);//渲染场景
  };
  window.scheduleFrame();//触发vsync

}

/// 通过 PaintingContext 进行绘制，组合多个图层
void test2() {

  ContainerLayer containerLayer = ContainerLayer();

  PaintingContext paintingContext = PaintingContext(containerLayer, Rect.zero);

  Paint circle1Paint= Paint();
  circle1Paint.color = Colors.blue;

  // 注释1
  // paintingContext.canvas.save();

  // 对画布进行裁剪
  //
  paintingContext.canvas.clipRect(Rect.fromCenter(center: Offset(400, 400), width: 280, height: 600));

  // 在裁剪后的画布上画一个⭕️
  //
  paintingContext.canvas.drawCircle(Offset(400, 400), 300, circle1Paint);

  // 注释2
  // paintingContext.canvas.restore();

  void _painter(PaintingContext context, Offset offset) {
    Paint circle2Paint = Paint();
    circle2Paint.color = Colors.red;
    context.canvas.drawCircle(Offset(400, 400), 250, circle2Paint);
  }

  // 通过 pushClipRect 方法再次执行裁剪
  // 注意此处 needsCompositing 参数为 true
  //
  paintingContext.pushClipRect(true, Offset.zero, Rect.fromCenter(center: Offset(500, 400), width: 200, height: 200), _painter,);

  Paint circle3Paint= Paint();
  circle3Paint.color = Colors.yellow;

  // 再次画一个⭕️
  paintingContext.canvas.drawCircle(Offset(400, 800), 200, circle3Paint);
  paintingContext.stopRecordingIfNeeded();

  SceneBuilder sceneBuilder = SceneBuilder();
  containerLayer.addToScene(sceneBuilder);
  sceneBuilder.pop();

  // 生成 Scene
  Scene scene = sceneBuilder.build();

  window.onDrawFrame = () {
    window.render(scene);
  };
  window.scheduleFrame();
}
