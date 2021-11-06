




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTestPage extends StatelessWidget {
  const AppBarTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
                collapsedHeight: 100,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('1232'),
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    child: FlutterLogo(),
                  ),
                ),
              ),

              SliverPersistentHeader(delegate: _SliverPersistentHeaderDelegate(
                child: FlexibleSpaceBar.createSettings(
                  maxExtent: 200,
                  minExtent: 100,
                  currentExtent: 200,
                    isScrolledUnder: false,

                  child: Container(
                    child: FlutterLogo(),
                  ),
                ),
                maxHeight: 200,
                minHeight: 100,
              ),
                pinned: true,
              ),
            ];
          },
          body: Expanded(
            child: ListView.builder(itemBuilder: (context, index) => Text('====${index}'),
            itemCount: 10,),
          ),
        ),

      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {

  _SliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //孩子

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}


