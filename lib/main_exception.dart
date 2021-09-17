import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ErrorsHandler {
  initialize() {}

  onError({FlutterErrorDetails? details, Object? error, StackTrace? stack}) {}

}

var myErrorsHandler = ErrorsHandler();


void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await myErrorsHandler.initialize();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      myErrorsHandler.onError(details: details);
      exit(1);
    };
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    myErrorsHandler.onError(error: error, stack: stack);
    exit(1);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        Widget error = Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        if(widget == null)
          widget = Text('');
        return widget;
      },
    );
  }
}
