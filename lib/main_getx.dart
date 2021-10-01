import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


abstract class AppRoutes {
  static const Home = '/home';
  static const List = '/list';
  static const Detail = '/detail';
}

final _routes = [
  GetPage(
    name: AppRoutes.Home,
    page: () => Home(),
    children: [
      GetPage(
        name: AppRoutes.List,
        page: () => ListView(),
        children: [
          GetPage(
            name: AppRoutes.Detail,
            page: () => DetailView(),
          ),
        ],
      ),
    ],
  ),
];

void main() =>
    runApp(GetMaterialApp(
      initialRoute: AppRoutes.Home,
      getPages: _routes,
      // home: Home(),
    ));

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;

  StreamController<String> name = StreamController<String>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    name.close();
    super.onClose();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //添加依赖管理
    final Controller controller = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Clicks: ${controller.count}')),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Go to Other'),
              onPressed: () => Get.to(Other()),
            ),
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              child: Text('改变主题'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  "Hey i'm a Get SnackBar!", // title
                  "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!",
                  // message
                  icon: Icon(Icons.alarm),
                  shouldIconPulse: true,
                  onTap: (_) {},
                  barBlur: 20,
                  isDismissible: true,
                  duration: Duration(seconds: 3),
                );
              },
              child: Text('测试snackbar'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    onConfirm: () {
                      Get.back();
                    },
                    onCancel: () {},
                    middleText: "Dialog made in 3 lines of code");
              },
              child: Text('Dialog'),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.music_note),
                            title: Text('Music'),
                            onTap: () {}),
                        ListTile(
                          leading: Icon(Icons.videocam),
                          title: Text('Video'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ));
                },
                child: Text('bottomSheet')),
            ElevatedButton(onPressed: () {
              Get.toNamed("/home/list/detail");
            }, child: Text('嵌套跳转')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}

class Other extends StatelessWidget {
  final Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Other2----->${controller.count.value}'),
            GetBuilder<Controller>(
              init: Controller(),
              builder: (_) => Text('GetBuilder----->${_.count.value}'),
            ),
          ],
        ),
      ),
    );
  }
}

class Other2 extends GetView<Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Other2----->${controller.count.value}'),
      ),
    );
  }
}

class Other3 extends GetView<GetxController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("导航-返回"),
            subtitle: Text('Get.back()'),
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }
}