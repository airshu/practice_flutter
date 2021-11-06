import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: SafeArea(child: _NotificationWidget()))));


class _NotificationWidget extends StatefulWidget {
  const _NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget> {

  String _msg = '';

  @override
  Widget build(BuildContext context) {
    return buildBody2();
  }

  Widget buildBody2() {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print('1111 ${notification.msg}');
        return true;
      },
      child: NotificationListener<MyNotification>(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return ElevatedButton(onPressed: (){
                MyNotification('Hi').dispatch(context);
              }, child: Text('Send Notification'));
            },),
            Text(_msg),
          ],
        ),
      ), onNotification: (notification) {
        print('2222222  ');
        setState(() {
          _msg += notification.msg + '  ';
        });
        return false;// 如果设置为false，则不会阻止冒泡
      },),
    );
  }


  Widget buildBody() {
    return NotificationListener<MyNotification>(child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            return ElevatedButton(onPressed: (){
              MyNotification('Hi').dispatch(context);
            }, child: Text('Send Notification'));
          },),
          Text(_msg),
        ],
      ),
    ), onNotification: (notification) {
      setState(() {
        _msg += notification.msg + '  ';
      });
      return true;
    },);
  }
}

class MyNotification extends Notification {

  final String msg;

  MyNotification(this.msg);
}
