import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: StreamBuilderTestWidget(),
  ));
}


///
class StreamBuilderTestWidget extends StatelessWidget {
  late StreamController<String> _streamController;
  late StreamSink _streamSink;
  late StreamSubscription _streamSubscription;

  StreamBuilderTestWidget({Key? key}) : super(key: key) {

    // _streamController = StreamController<String>(); //
    _streamController = StreamController.broadcast(); //
    _streamSink = _streamController.sink;
    _streamSubscription = _streamController.stream.listen((event) {
      print('listen ======= $event');
    });
  }

  void close() {
    _streamController.close(); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
            builder: (context, snapshot) {
              print('---------snapshot=${snapshot}');
              if(snapshot.hasError) {
                return Text('error');
              } else {
                return Text('---${snapshot.data}');
              }
            },
            stream: _streamController.stream,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        int code = Random().nextInt(100);
        if(code ==50) {
          _streamSink.addError('error');
        } else {
          _streamSink.add(code.toString());
        }
      },child: Icon(Icons.add),),
    );
  }
}
