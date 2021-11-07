import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: HeroAnimationRoute()),
    ),
  );
}

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                child: ClipOval(
                  child: Image.asset(
                    "images/logo.png",
                    width: 50.0,
                  ),
                ),
              ),
              onTap: () {
                //打开B路由
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (
                      BuildContext context,
                      animation,
                      secondaryAnimation,
                      ) {
                    return FadeTransition(
                      opacity: animation,
                      child: Scaffold(
                        appBar: AppBar(
                          title: Text("原图"),
                        ),
                        body: HeroAnimationRouteB(),
                      ),
                    );
                  },
                ));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            )
          ],
        ),
      ),
    );
  }
}
class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("images/logo.png"),
      ),
    );
  }
}
