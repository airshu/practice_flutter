
```dart


class Window {
    
  // 当前设备的DPI，即一个逻辑像素显示多少物理像素，数字越大，显示效果就越精细保真。
  // DPI是设备屏幕的固件属性，如Nexus 6的屏幕DPI为3.5 
  double get devicePixelRatio => _devicePixelRatio;
  
  // Flutter UI绘制区域的大小
  Size get physicalSize => _physicalSize;

  // 当前系统默认的语言Locale
  Locale get locale;
    
  // 当前系统字体缩放比例。  
  double get textScaleFactor => _textScaleFactor;  
    
  // 当绘制区域大小改变回调
  VoidCallback get onMetricsChanged => _onMetricsChanged;  
  // Locale发生变化回调
  VoidCallback get onLocaleChanged => _onLocaleChanged;
  // 系统字体缩放变化回调
  VoidCallback get onTextScaleFactorChanged => _onTextScaleFactorChanged;
  // 绘制前回调，一般会受显示器的垂直同步信号VSync驱动，当屏幕刷新时就会被调用
  FrameCallback get onBeginFrame => _onBeginFrame;
  // 绘制回调  
  VoidCallback get onDrawFrame => _onDrawFrame;
  // 点击或指针事件回调
  PointerDataPacketCallback get onPointerDataPacket => _onPointerDataPacket;
  // 调度Frame，该方法执行后，onBeginFrame和onDrawFrame将紧接着会在合适时机被调用，
  // 此方法会直接调用Flutter engine的Window_scheduleFrame方法
  void scheduleFrame() native 'Window_scheduleFrame';
  // 更新应用在GPU上的渲染,此方法会直接调用Flutter engine的Window_render方法
  void render(Scene scene) native 'Window_render';

  // 发送平台消息
  void sendPlatformMessage(String name,
                           ByteData data,
                           PlatformMessageResponseCallback callback) ;
  // 平台通道消息处理回调  
  PlatformMessageCallback get onPlatformMessage => _onPlatformMessage;
  
  ... //其它属性及回调
   
}



```


- GestureBinding：提供了window.onPointerDataPacket 回调，绑定Framework手势子系统，是Framework事件模型与底层事件的绑定入口。
- ServicesBinding：提供了window.onPlatformMessage 回调， 用于绑定平台消息通道（message channel），主要处理原生和Flutter通信。
- SchedulerBinding：提供了window.onBeginFrame和window.onDrawFrame回调，监听刷新事件，绑定Framework绘制调度子系统。
- PaintingBinding：绑定绘制库，主要用于处理图片缓存。
- SemanticsBinding：语义化层与Flutter engine的桥梁，主要是辅助功能的底层支持。
- RendererBinding: 提供了window.onMetricsChanged 、window.onTextScaleFactorChanged 等回调。它是渲染树与Flutter engine的桥梁。
- WidgetsBinding：提供了window.onLocaleChanged、onBuildScheduled 等回调。它是Flutter widget层与engine的桥梁。


调度过程

SchedulerBinding.handleDrawFrame

依次处理transientCallbacks、midFrameMicrotasks、persistentCallbacks、postFrameCallbacks

```dart

enum SchedulerPhase {
  
  /// 空闲状态，并没有 frame 在处理。这种状态代表页面未发生变化，并不需要重新渲染。
  /// 如果页面发生变化，需要调用`scheduleFrame()`来请求 frame。
  /// 注意，空闲状态只是指没有 frame 在处理，通常微任务、定时器回调或者用户事件回调都
  /// 可能被执行，比如监听了tap事件，用户点击后我们 onTap 回调就是在idle阶段被执行的。
  idle,

  /// 执行”临时“回调任务，”临时“回调任务只能被执行一次，执行后会被移出”临时“任务队列。
  /// 典型的代表就是动画回调会在该阶段执行。
  transientCallbacks,

  /// 在执行临时任务时可能会产生一些新的微任务，比如在执行第一个临时任务时创建了一个
  /// Future，且这个 Future 在所有临时任务执行完毕前就已经 resolve 了，这中情况
  /// Future 的回调将在[midFrameMicrotasks]阶段执行
  midFrameMicrotasks,

  /// 执行一些持久的任务（每一个frame都要执行的任务），比如渲染管线（构建、布局、绘制）
  /// 就是在该任务队列中执行的.
  persistentCallbacks,

  /// 在当前 frame 在结束之前将会执行 postFrameCallbacks，通常进行一些清理工作和
  /// 请求新的 frame。
  postFrameCallbacks,
}


```

当新的 frame 到来时，调用到 WidgetsBinding 的 drawFrame() 方法
```dart
@override
void drawFrame() {
 ...//省略无关代码
  try {
    buildOwner.buildScope(renderViewElement); // 先执行构建
    super.drawFrame(); //然后调用父类的 drawFrame 方法
  } 
}


void drawFrame() {
  buildOwner!.buildScope(renderViewElement!); // 1.重新构建widget树
  //下面是 展开 super.drawFrame() 方法
  pipelineOwner.flushLayout(); // 2.更新布局
  pipelineOwner.flushCompositingBits(); //3.更新“层合成”信息
  pipelineOwner.flushPaint(); // 4.重绘
  if (sendFramesToEngine) {
    renderView.compositeFrame(); // 5. 上屏，会将绘制出的bit数据发送给GPU
  ...
}
}

```


setState执行流程

1. 首先调用当前 element 的 markNeedsBuild 方法，将当前 element标记为 dirty 。
2. 接着调用 scheduleBuildFor，将当前 element 添加到piplineOwner的 dirtyElements 列表。
3. 最后请求一个新的 frame，随后会绘制新的 frame：onBuildScheduled->ensureVisualUpdate->scheduleFrame() 。当新的 frame 到来时执行渲染管线

```dart
void drawFrame() {
  buildOwner!.buildScope(renderViewElement!); //重新构建widget树
  pipelineOwner.flushLayout(); // 更新布局
  pipelineOwner.flushCompositingBits(); //更新合成信息
  pipelineOwner.flushPaint(); // 更新绘制
  if (sendFramesToEngine) {
    renderView.compositeFrame(); // 上屏，会将绘制出的bit数据发送给GPU
    pipelineOwner.flushSemantics(); // this also sends the semantics to the OS.
    _firstFrameSent = true;
  }
}

```

}

1. 重新构建 widget 树：如果 dirtyElements 列表不为空，则遍历该列表，调用每一个element的rebuild方法重新构建新的widget（树），由于新的widget(树)
使用新的状态构建，所以可能导致widget布局信息（占用的空间和位置）发生变化，如果发生变化，则会调用其renderObject的markNeedsLayout方法，该方法会从当前节点向父级查找，直到找到一个relayoutBoundary的节点，然后会将它添加到一个全局的nodesNeedingLayout列表中；如果直到根节点也没有找到relayoutBoundary，则将根节点添加到nodesNeedingLayout列表中。
2. 更新布局：遍历nodesNeedingLayout数组，对每一个renderObject重新布局（调用其layout方法），确定新的大小和偏移。layout方法中会调用markNeedsPaint()，该方法和 
markNeedsLayout 方法功能类似，也会从当前节点向父级查找，直到找到一个isRepaintBoundary属性为true的父节点，然后将它添加到一个全局的nodesNeedingPaint列表中；由于根节点（RenderView）的 isRepaintBoundary 为 true，所以必会找到一个。查找过程结束后会调用 buildOwner.requestVisualUpdate 方法，该方法最终会调用scheduleFrame()，该方法中会先判断是否已经请求过新的frame，如果没有则请求一个新的frame。
3. 更新合成信息：先忽略，后面我们专门介绍。
4. 更新绘制：遍历nodesNeedingPaint列表，调用每一个节点的paint方法进行重绘，绘制过程会生成Layer。需要说明一下，flutter中绘制结果是是保存在Layer中的，也就是说只要Layer
不释放，那么绘制的结果就会被缓存，因此，Layer可以跨frame来缓存绘制结果，避免不必要的重绘开销。Flutter框架绘制过程中，遇到isRepaintBoundary 为 true 的节点时，才会生成一个新的Layer。可见Layer和 renderObject 不是一一对应关系，父子节点可以共享，这个我们会在随后的一个试验中来验证。当然，如果是自定义组件，我们可以在renderObject中手动添加任意多个 Layer，这通常用于只需一次绘制而随后不会发生变化的绘制元素的缓存场景，这个随后我们也会通过一个例子来演示。
5. 上屏：绘制完成后，我们得到的是一棵Layer树，最后我们需要将Layer树中的绘制信息在屏幕上显示。我们知道Flutter是自实现的渲染引擎，因此，我们需要将绘制信息提交给Flutter 
engine，而renderView.compositeFrame 正是完成了这个使命。