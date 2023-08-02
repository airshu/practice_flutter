import 'package:flutter/material.dart';
import 'package:practice_flutter/layout/constraint_test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/nested': (_) => NestedScrollViewPage(),
        '/custom': (_) => CustomScrollViewPage(),
      },
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('NestedScollView'),
                  onPressed: () async {
                    await Navigator.of(context).pushNamed('/nested');
                  },
                ),
                ElevatedButton(
                  child: Text('CustomScollView'),
                  onPressed: () async {
                    await Navigator.of(context).pushNamed('/custom');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NestedScrollViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('NestedScrollView'),
                expandedHeight: 300,
              ),
            ),
          ];
        },
        body: Builder(builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                  child: Container(
                    color: Colors.amber,
                    height: 100,
                  )),
            ],
          );
        }),
      ),
    );
  }
}

class CustomScrollViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('CustomScrollView'),
            expandedHeight: 300,
          ),
          SliverToBoxAdapter(
              child: Container(
                color: Colors.amber,
                height: 100,
              )),
        ],
      ),
    );
  }
}