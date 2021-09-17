import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practice_flutter/utils/logger_util.dart';
import 'dart:developer' as developer;

class WidgetLifeCyclePage extends StatefulWidget {
  const WidgetLifeCyclePage({Key? key}) : super(key: key);

  @override
  _WidgetLifeCyclePageState createState() => _WidgetLifeCyclePageState();
}

class _WidgetLifeCyclePageState extends State<WidgetLifeCyclePage> {
  late int _count;

  @override
  void initState() {
    _count = 0;
    logger.i('initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    logger.i('didChangeDependencies');
    stderr.writeln('didChangeDependencies=========');
    developer.log('message', name: 'hahaha', error: _count.toString());
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    logger.i('reassemble');
    developer.log('message', name: 'hahaha', error: _count.toString());
    super.reassemble();
  }

  @override
  void didUpdateWidget(covariant WidgetLifeCyclePage oldWidget) {
    logger.i('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    logger.i('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.i('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: Text('$_count')),
      ),
    );
  }
}
