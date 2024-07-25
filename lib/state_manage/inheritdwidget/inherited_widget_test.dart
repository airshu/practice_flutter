import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// InheritedWidget实例
void main() {
  // debugPrintBuildScope = true;//Widget构建
  // debugPrintScheduleBuildForStacks = false;//调度构建堆栈
  // debugPrintGlobalKeyedWidgetLifecycle = false;//GlobalKey的生命周期信息
  // debugProfileBuildsEnabled = false;//打印性能相关信息
  runApp(
    MaterialApp(
      home: Scaffold(body: InheritedWidgetTestRoute()),
    ),
  );
}

class FooWidget extends StatelessWidget {
  const FooWidget();

  @override
  Widget build(BuildContext context) {
    print('>>>>>>>>>>>>>>FooWidget build');
    return const Placeholder();
  }
}


class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('>>>>>>>>>>>>>>_InheritedWidgetTestRouteState build');
    return Center(
      child: ShareDataWidget(
        //使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TestInheritWidget(), //子widget中依赖ShareDataWidget
            ),
            FooWidget(),
            ElevatedButton(
              child: const Text("Increment"),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() {
                // ++count;
              }),
            )
          ],
        ),
      ),
    );
  }
}

class TestInheritWidget extends StatefulWidget {
  @override
  _TestInheritWidgetState createState() => _TestInheritWidgetState();
}

class _TestInheritWidgetState extends State<TestInheritWidget> {
  @override
  Widget build(BuildContext context) {
    print('>>>>>>>build _TestInheritWidgetState');
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("_TestInheritWidgetState  Dependencies change");
  }

  @override
  void didUpdateWidget(covariant TestInheritWidget oldWidget) {
    print('_TestInheritWidgetState   didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({Key? key, required Widget child, required this.data}) : super(key: key, child: child);

  final int data;

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
