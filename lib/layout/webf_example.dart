import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webf/devtools.dart';
import 'package:webf/webf.dart';

void main() {
  runApp(MaterialApp(
    home: WebfExample(),
  ));
}

class WebfExample extends StatefulWidget {
  WebfExample();

  @override
  State<WebfExample> createState() => _WebfExampleState();
}

class _WebfExampleState extends State<WebfExample> {
  WebFController? controller;

  WebFJavaScriptChannel javaScriptChannel = WebFJavaScriptChannel();

  @override
  void initState() {
    super.initState();

    javaScriptChannel.onMethodCall = handleJSCall;
  }

  Future<dynamic> handleJSCall(String method, dynamic args) async {

  }

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      controller ??= WebFController(context);

    }

    final MediaQueryData queryData = MediaQuery.of(context);
    final Size viewportSize = queryData.size;
    return Scaffold(
        body: Center(
          child: WebF(
            javaScriptChannel: javaScriptChannel,
            controller: controller,
            devToolsService: ChromeDevToolsService(), // Enable Chrome DevTools Services
            // viewportWidth: viewportSize.width - queryData.padding.horizontal, // Adjust the viewportWidth
            // viewportHeight: viewportSize.height - queryData.padding.vertical, // Adjust the viewportHeight
            bundle: WebFBundle.fromUrl('http://10.193.207.55:3000/'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            javaScriptChannel.invokeMethod("xxx", {});//调用js方法
          },
          child: Icon(Icons.refresh),
        ));
  }
}

class PlatformCommunicator {
  static const platform = const MethodChannel('com.example.myapp/platform_channel');

  static Future<String> communicateWithWeb(String message) async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('communicate', {"message": message});
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to communicate: '${e.message}'.";
    }
    return response;
  }
}
