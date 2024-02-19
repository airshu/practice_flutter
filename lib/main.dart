import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/bloc_example/bloc_example_1.dart';
import 'package:practice_flutter/go_route/go_route_main.dart';
import 'package:practice_flutter/plugin_example/plugin_example.dart';
import 'package:practice_flutter/route/named_navigator.dart';
import 'package:practice_flutter/route/navigator2_nested.dart';
import 'package:practice_flutter/route/navigator2_simple_test.dart';
import 'package:practice_flutter/route/navigator2_test.dart';
import 'package:practice_flutter/route/navigator_main.dart';
import 'package:practice_flutter/scroll_example/test.dart';
import 'package:practice_flutter/share_example/share_main.dart';
import 'package:practice_flutter/state_manage/inheritdwidget/inherited_widget_test.dart';
import 'package:practice_flutter/state_manage/provider/provider_test.dart';
import 'package:practice_flutter/state_manage/valuelistenablebuilder_test.dart';
import 'package:practice_flutter/text/expand_text.dart';

import 'animate/test.dart';
import 'common/base_state.dart';
import 'ffmpeg/audio_example.dart';
import 'layout/constraint_test.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 示例'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildButton('AnimationDemo', () => AnimationDemo()),
              buildButton('Bloc Demo', () => BlocExample()),
              buildButton('AudioExample', () => AudioExample1()),
              buildButton('GoRouterMyApp', () => GoRouterMyApp()),
              buildButton('ConstraintHomePage', () => ConstraintHomePage()),
              buildButton('PluginMyApp', ()=> PluginMyApp()),
              buildButton('NavigatorMainApp', () => NavigatorMainApp()),
              buildButton('ScrollMyApp', () => ScrollMyApp()),
              buildButton('ShareDemoApp', () => ShareDemoApp()),
              buildButton('InheritedWidgetTestRoute', () => InheritedWidgetTestRoute()),
              buildButton('ProviderRoute', () => ProviderRoute()),
              buildButton('ValueListenableRoute', () => ValueListenableRoute()),
              buildButton('可折叠文本控件', () => TextApp1()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String title, Function pageBuilder) {
    return BaseButtonWidget(
      title: title,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return pageBuilder();
        }));
      },
    );
  }
}
