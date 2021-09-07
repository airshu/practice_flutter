import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/model/items.dart';

/**
 * 通用语录
 */
class NormalPage extends StatefulWidget {
  @override
  State<NormalPage> createState() => _NormalPageState();
}

class _NormalPageState extends State<NormalPage> {
  @override
  void initState() {
    super.initState();
    _resetCards();
  }

  void _resetCards() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    var items = Provider.of<Items>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
          ),
          child: PageView.builder(
            itemBuilder: (context, index) {
              return PageItem(
                  items.fileNames[index], Colors.transparent, index);
            },
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              print(value.toString() + "=======");
            },
          ),
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final String title;
  final Color color;
  final int itemNo;

  PageItem(this.title, this.color, this.itemNo);

  @override
  Widget build(BuildContext context) {
    var items = Provider.of<Items>(context);

    return Column(children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ios_share),
            SizedBox.fromSize(
              size: Size(30, 1),
            ),
            IconButton(
                onPressed: () {
                  !items.items.contains(itemNo)
                      ? items.add(itemNo)
                      : items.remove(itemNo);
                },
                icon: items.items.contains(itemNo)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border))
          ],
        ),
      ),
    ]);
  }
}
