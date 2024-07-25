import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/state_manage/inheritdwidget/inherited_widget_test.dart';

void main() {
  runApp(MaterialApp(home: SetStateExample(),));
}


class SetStateExample extends StatefulWidget {
  const SetStateExample();

  @override
  State<SetStateExample> createState() => _SetStateExampleState();
}

class _SetStateExampleState extends State<SetStateExample> {


  _SetStateExampleState() {
    print('>>>>>_SetStateExampleState  $hashCode');
  }

  int count = 0;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              count++;
            });
          },
          child: Container(
            height: 40,
            width: 300,
            color: Colors.red,
            child: ShareDataWidget(
              data: count,
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      child: child ?? FirstWidget(),
                    ),
                    TestInheritWidget(),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            print('setState');
            // child = SecondWidget();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class FirstWidget extends StatefulWidget {
  FirstWidget(){
      print('>>>>>FirstWidget  $hashCode');
  }

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  final String tag = 'FirstWidgetState';

  _FirstWidgetState() {
    print('>>>>>_FirstWidgetState  $hashCode');
  }

  @override
  void initState() {
    print('$tag initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FirstWidget oldWidget) {
    print('$tag didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('$tag didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('$tag build  $hashCode');
    return const Text('FirstWidgetState');
  }
}


class SecondWidget extends StatefulWidget {
  const SecondWidget();

  @override
  State<SecondWidget> createState() => _SecondWidgetState();
}


class _SecondWidgetState extends State<SecondWidget> {

  final String tag = 'SecondWidgetState';

  @override
  void initState() {

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SecondWidget oldWidget) {
    print('$tag didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('$tag didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('$tag build');
    return const Text('SecondWidgetState');
  }
}


