import 'package:flutter/material.dart';
import 'package:practice_flutter/layout/constraint_test.dart';

void main() => runApp(ScrollMyApp());

class ScrollMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/nested': (_) => NestedScrollViewPage(),
        '/custom': (_) => CustomScrollViewPage(),
        '/wechatMine': (_) => WechatMinePage(),
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

class NestedScrollViewPage extends StatefulWidget {
  @override
  State<NestedScrollViewPage> createState() => _NestedScrollViewPageState();
}

class _NestedScrollViewPageState extends State<NestedScrollViewPage> {


  Widget buildBody() {
    return NestedScrollView(
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
                child: GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      print('onTapDown>>>>>>>>>>>>>>>>>>>>>>>>${DateTime.now()}');
                    });
                  },
                  child: Container(
                    color: Colors.amber,
                    height: 100,
                  ),
                )),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('-----------');
    return Scaffold(
      body: buildBody(),
      // body: Scrollbar(
      //   child: Container(color: Colors.red,),
      // ),
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

class WechatMinePage extends StatelessWidget {
  const WechatMinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
