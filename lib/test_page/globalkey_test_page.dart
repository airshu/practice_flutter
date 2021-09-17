import 'package:flutter/material.dart';

class GlobalkeyTestPage extends StatefulWidget {
  const GlobalkeyTestPage({Key? key}) : super(key: key);

  @override
  _GlobalkeyTestPageState createState() => _GlobalkeyTestPageState();
}

class _GlobalkeyTestPageState extends State<GlobalkeyTestPage> {


  final GlobalKey<_SwitchWidgetState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          key.currentState!.changeState();
        },
        child: Text('切换'),
      ),
      body: SwitchWidget(key: key,),
    );
  }


}


class SwitchWidget extends StatefulWidget {
  const SwitchWidget({Key? key}) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {

  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Switch.adaptive(
          value: isActive,
          onChanged: (currentStatus) {
            setState(() {
              isActive = currentStatus;
            });

          },
        ),
      ),
    );
  }

  changeState() {
    setState(() {
      isActive = !isActive;
    });

  }
}
