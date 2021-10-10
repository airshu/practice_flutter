

import 'package:flutter/material.dart';

/**
 * 语录集合
 */
class Items extends ChangeNotifier {

  List<String> fileNames = [
    '做自己的太阳\n不用凭借谁的光',
    '你不能要求没有风景的海洋。那不是海，是泥潭。',
    '保持信念，生命中最神奇的事，往往在你快要失去希望的那一刻发生。',
    '如果别人朝你扔石头，就不要扔回去了，留着作你建高楼的基石。',
    '既然选择了远方便只顾风雨兼程',
    '难熬的日子总会过去，不信回头看看，你都已经在不知不觉中熬过了很多苦难。',
    '人因为有理想、梦想而变得伟大，而真正伟大就是不断努力实现理想、梦想。',
    '要让事情改变先改变我自己\n要让事情变得更好\n先让自己变得更好',
    '有时候，坚持了你最不想干的事情之后，便可得到你最想要的东西。',
    '丛容地度过每一天，感恩每一件小事。别让自己陷入不可控的状态，接纳它，并尽力而为。',
    '你生来就值得被爱\n这一点你无需质疑',
    '多数人都拥有自己不了解的能力和机会，都有可能做到未曾梦想的事情。',
    '你唯一应该超越的人，就是昨天的你，每天进步，每天都能成为更好的自己。',
    '发光不是太阳的权利，每个人都可以。',
    '你专注认真的样子最好看',
    '时间没有治愈你，是你自己的坚强和努力治愈了自己。',
  ];

  final List<int> _favoriteItems = [];

  List<int> get items => _favoriteItems;

  void add(int itemNo) {
    _favoriteItems.add(itemNo);
    notifyListeners();
  }

  void remove(int itemNo) {
    _favoriteItems.remove(itemNo);
    notifyListeners();
  }


}