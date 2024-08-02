import 'package:flutter/material.dart';

void main() {
  runApp(
    RootRestorationScope(
      restorationId: "app",
      child: RestorationApp(),
    ),
  );
}

class RestorationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restorable Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RestorableCounter(),
    );
  }
}

class RestorableCounter extends StatefulWidget {
  @override
  _RestorableCounterState createState() => _RestorableCounterState();
}

class _RestorableCounterState extends State<RestorableCounter>
    with RestorationMixin {
  RestorableInt _counter = RestorableInt(0);

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  // The restoration bucket id for this page,
  // let's give it the name of our page!
  String get restorationId => "counter_page";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Register our property to be saved every time it changes,
    // and to be restored every time our app is killed by the OS!
    registerForRestoration(_counter, 'count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restorable Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }
}