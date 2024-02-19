
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(_NavigatorUI());
}

class _NavigatorUI extends StatefulWidget {
  const _NavigatorUI({super.key});

  @override
  State<_NavigatorUI> createState() => _NavigatorUIState();
}

class _NavigatorUIState extends State<_NavigatorUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: 300,
          child: Column(
            children: [
              Container(
                height: 44,
                child: NavigationToolbar(
                  middleSpacing: 0,
                  leading: Container(
                    width: 100,
                    color: Colors.red,
                  ),
                  middle: Container(
                    color: Colors.blue,
                  ),
                  trailing: Container(
                    width: 100,
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(child: Text('123123213')),

            ],
          ),
        ),
      ),
    );
  }
}
