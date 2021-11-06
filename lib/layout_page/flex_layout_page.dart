import 'package:flutter/material.dart';

/// Row、Column假装最大约束无解
/// 对弹性布局使用紧约束
///
/// 为什么ListView不能直接嵌套在Row、Column中？
///
/// 因为Row、Column默认最大约束为无穷，ListView也是，冲突了。
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        color: Colors.grey,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: (){}, child: Text('1111')),
            FlutterLogo(
              size: 150,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                print(constraints.toString());
                return Container(
                  color: Colors.yellow,
                  width: 50,
                  child: Container(
                      color: Colors.red,
                      height: 20,
                      width: 20,
                      child: FlutterLogo(
                        size: 200,
                      )),
                );
              },
            ),
            Text('11222'),
            Text('2332'),
            // Flexible(
            //   child: FlutterLogo(),
            //   flex: 1,
            // ),
          ],
        ),
      ),
    ),
  ));
}
