import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';


class PageViewDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      items: _item(),
      ),
    );
  }

  List<BottomNavigationBarItem> _item() {
    return [
      _bottomItem('首页', 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem('发现', 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem('热门', 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem('我的', 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectorIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        normalIcon,
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        selectorIcon,
        width: 24,
        height: 24,
      ),
      label: title,
    );
  }


}

class PagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PageLogic());
    final state = Get.find<PageLogic>().state;

    return Container();
  }
}
