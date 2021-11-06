import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: SafeArea(child: _NotificationWidget()))));

class _NotificationWidget extends StatelessWidget {
  const _NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NotificationListener(
        onNotification: (notification) {
          print('-----${notification.runtimeType}');
          return true;
        },
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text('$index'),
          ),
          itemCount: 100,
        ),
      ),
    );
  }
}
