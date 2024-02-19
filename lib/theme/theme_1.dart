import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: TextStyle(
      color: Colors.red,
    ))),
    home: Scaffold(
      body: Center(
        child: App(),
      ),
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Hello World'),
          ElevatedButton(onPressed: () {}, child: Text('Button1')),
        ],
      ),
    );
  }
}
