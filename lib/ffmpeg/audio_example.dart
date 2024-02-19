import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/utils/audio_util.dart';
import 'package:practice_flutter/utils/auido_player.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(AudioExample1());
}

class AudioExample1 extends StatelessWidget {
  AudioExample1({Key? key}) : super(key: key);

  PageController pageController = PageController();

  final name1 = 'nam1';

  final name2 = 'name2';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          child: Row(
            children: [
              Column(
                children: [
                  CupertinoButton(
                      child: Text('menu1'),
                      onPressed: () {
                        pageController.jumpToPage(0);
                      }),
                  CupertinoButton(
                      child: Text('menu2'),
                      onPressed: () {
                        pageController.jumpToPage(1);
                      }),
                ],
              ),
              Expanded(
                child: Container(
                  child: PageView(
                    controller: pageController,
                    children: [
                      TestPage(pageName: 'test1',),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class TestPage extends StatelessWidget {
  TestPage({Key? key, required this.pageName}) : super(key: key);

  final String pageName;

  static const String opportunityDetail = '/opportunity/main/detailV2'; // 商机客户详情V2
  static const String opportunityMain = '/opportunity/main';


  @override
  Widget build(BuildContext context) {
    return Container(
      child: TestPage1(pageName: 'aaa',)
    );
  }
}

class TestPage1 extends StatelessWidget {
  TestPage1({Key? key, required this.pageName}) : super(key: key);

  final String pageName;

  @override
  Widget build(BuildContext context) {
    print('Testpage1  build====>>>>  $pageName');
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            ElevatedButton(onPressed: ()async {
              var tempDir = await getTemporaryDirectory();
              String path = '${tempDir.path}/output2.aac';
              WSAudioPlayer.instance.play(path);
            }, child: Text('存储目录播放')),
            ElevatedButton(
              child: const Text('Pop!'),
              onPressed: () {
                // Navigator.pop(context);

                String path = 'assets/files/01.aac';
                path = 'assets/files/merged_caf.aac';
                WSAudioPlayer.instance.playAsset(path);
              },
            ),
            ElevatedButton(
              child: Text(
                '播放url',
              ),
              onPressed: () {

                String url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231225/8c11a8d5eef6405785f080158bfe522d/1702370874740?Expires=1703585963&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=lbu2nDwC18NtNdRNf2iCOWUcZXQ%3D';
                url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231225/8c11a8d5eef6405785f080158bfe522d/1691224619651?Expires=1703586358&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=teIdM5F1Q0dFjUhzpXDpj00x2nY%3D';

                url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231225/8c11a8d5eef6405785f080158bfe522d/1691229788681.aac?Expires=1703586523&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=g7%2FpPYdLDbH9qB0c9elSfQbGI2g%3D';
                // url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231225/8c11a8d5eef6405785f080158bfe522d/1691206766618.caf?Expires=1703586691&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=cSj19LszA3wyOn8TmQo%2FZOTjQ1g%3D';
                //
                // url = 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/01.aac';
                // url = 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/13.wav';

                url = 'https://app-download-eu.x-peng.com/xp-scepter-app/web/1703559776152.aac';

                // url = 'https://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/employee/upload/common/test/2023-10-12/1702371866533.wav?Expires=1703556997&OSSAccessKeyId=STS.NUsMw8erTsQ7S1kGxRGtWEC9y&Signature=Bp6fkai%2BVUghvsnUNdMFWemWWA4%3D&security-token=CAIS9QR1q6Ft5B2yfSjIr5bGBs2MiK11xJPcURfao3gHS%2Ft7qoaSmzz2IHxLdHlrCe4Wtvw3lGpV6PsdlrtaVoNFRVHOQcZ%2B54lT7TmmZ4eZLSV5JR5d2vOfAmG2J0PRD6SwCryLdbGwU%2FOpbE%2B%2B2U0X6LDmdDKkckW4OJmS8%2FBOZcgWWQ%2FKClgjA8pKLAx%2FrsMQMmeDd4zaUHjQj3HXEVBjtydllGp78t7f%2BMCH7QfEh1CIoY185fZ7SPrJRs1oO4gFjL7XuMV9aqvG1gNJ9hFO790YpadY%2BDDBzCf0YTlW%2BA7UHOfIsL8KKxRiNJAnB4lOrvX3iZ8AvffIxbzq1zFHP%2BxeTw3UQOLQx9DfSsqjMcwlUKv%2FJ3XV28qTC4HxtAooAwkcLxgYQ906NkF3BSQoQyDeK7S7mi3NeRzxc7WP1KAt0aBpyk3T4cCHLl3tOrKCynQiN4QgaFklEBQU0Gf9EN8BaBceSV58G7GPQKJ5bh1VtZ3lpxbTUSsaOBg12cfzfPTLoKsSRJziV5Zdq%2BonaY9BrnEhQiYeItDjg0wPJmt%2BWuQUguu%2FOZPmrbOfyeqUZ6ndFvcds1pXNizctDbKCxEKJCbqtNo4cgjaqYaDzKCVtp96GQQp4JdEEQafeNlg6EBr%2BLeF4xWJt%2BT5V0e283EkvZu6s4BE8hljZez2wb3Q7D7S5Tmce6A2n8GQQ3FoWx24djtiwezVxFB%2F%2FkxRzzzvZE9Hsw3BijzqIfd2iKLbmil2ZY5IgvndRjua%2BWFtNMmE%2Bb5jW5k5IL8eAq3sg1ExnqW39UDu5tLbyx54e%2B70arEqboBBHhbv%2BqPpYMGnHQvevJJHExqAAV8bi0qXkC1XWzhngi%2FXF9do3AJsuyckcfvBSr%2BolpwvnLk5ZOKrmQDewAFCberNobkvKsBN8eU86lo11mYPxKIbm8Y5JHOJ%2FeWqYPyyUHZZy84HTBzo7RPjnrU8G87X%2FOi755Nv6esT%2BKI9cyI09xS%2BvQ%2FJyCx99B43cBbQjWvMIAA%3D';
                url = 'https://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/employee/upload/common/test/2023-10-12/1703559776152.aac?Expires=1703560541&OSSAccessKeyId=STS.NV5K1SZo5WU8gtesbjWGBQKkC&Signature=M%2FGl6XMEZN6OmX%2BnBizNWnh938M%3D&security-token=CAIS9QR1q6Ft5B2yfSjIr5WAAIvnt7AU4JfTZVLUl2I%2FW8huvo7AoTz2IHxLdHlrCe4Wtvw3lGpV6PsdlrtaVoNFRVHOQcZ%2B54lT7TmmZ4eZHU4OJx5d2vOfAmG2J0PRD6SwCryLdbGwU%2FOpbE%2B%2B2U0X6LDmdDKkckW4OJmS8%2FBOZcgWWQ%2FKClgjA8pKLAx%2FrsMQMmeDd4zaUHjQj3HXEVBjtydllGp78t7f%2BMCH7QfEh1CIoY185fZ7SPrJRs1oO4gFjL7XuMV9aqvG1gNJ9hFO790YpadY%2BDDBzCf0YTlW%2BA7UHOfIsL8KKxRiNJAnB4lOrvX3iZ8AvffIxbzq1zFHP%2BxeTw3UQOLQx9DfSsqjMcwlUKv%2FJ3XV28qTC4HxtAooAwkcLxgYQ906NkF3BSQoQyDeK7S7mi3NeRzxc7WP1KAt0aBpyk3T4cCHLl3tOrKCynQiN4QgaFklEBQU0Gf9EN8BaBceSV58G7GPQKJ5bh1VtZ3lpxbTUSsaOBg12cfzfPTLoKsSRJziV5Zdq%2BonaY9BrnEhQiYeItDjg0wPJmt%2BWuQUguu%2FOZPmrbOfyeqUZ6ndFvcds1pXNizctDbKCxEKJCbqtNo4cgjaqYaDzKCVtp96GQQp4JdEEQafeNlg6EBr%2BLeF4xWJt%2BT5V0e283EkvZu6s4BE8hljZez2wb3Q7D7S5Tmce6A2n8GQQ3FoWx24djtiwezVxFB%2F%2FkxRzzzvZE9Hsw3BijzqIfd2iKLbmil2ZY5IgvndRjua%2BWFtNMmE%2Bb5jW5k5IL8eAq3sg1ExnqW39UDu5tLbyx54e%2B70arEqboBBHhbv%2BqPpYMGnHQvevJJHExqAAa09bmmxe%2FRIgem8rHzNlrVBa%2BX6shmMVdAPAFXDWxinQ8hdzp7QmCrZI5epIa9fGvPMPhUyH6lphDLaLTBb6dWOs4V%2BlfCh7tkX8%2Fq5v%2BHTydw9B8CAp1klm9oFVRqT6RYSa3p94qRxaIC0KLoLzTs6mobMZZxGkQKhzch8cHrPIAA%3D';

                url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231227/8c11a8d5eef6405785f080158bfe522d/merged_caf.aac?Expires=1703745707&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=LdeLsAPy1St%2B%2BwbG8fFeYFN8x1w%3D';
                url = 'hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231227/8c11a8d5eef6405785f080158bfe522d/output2.aac?Expires=1703747002&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=0C37Pi30CQT%2BfDyBs8qikAJyIWY%3D';
                url = 'http://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/20231227/8c11a8d5eef6405785f080158bfe522d/merged_caf.mp3?Expires=1703747181&OSSAccessKeyId=LTAI5tBvDD4PcG5mCrwFqffH&Signature=fFOCMcrioXoG4wHQ6302VZC8i1o%3D';
                // url ='https://hd1-dragon.oss-cn-hangzhou.aliyuncs.com/storage/sit/employee/upload/common/test/2023-10-12/output2.aac?Expires=1704260917&OSSAccessKeyId=STS.NUR5WWXZ7QQkj3nz1WcqGY7kg&Signature=F6qq5LCk1%2BlGJZZJPfaR%2Fn8%2ByFg%3D&security-token=CAIS9QR1q6Ft5B2yfSjIr5bnfu3jtYUW5pOAaBXfnjECb%2F5rtvLAhTz2IHxLdHlrCe4Wtvw3lGpV6PsdlrtaVoNFRVHOQcZ%2B54lT7TmmZ4eZBGNnVx5d2vOfAmG2J0PRD6SwCryLdbGwU%2FOpbE%2B%2B2U0X6LDmdDKkckW4OJmS8%2FBOZcgWWQ%2FKClgjA8pKLAx%2FrsMQMmeDd4zaUHjQj3HXEVBjtydllGp78t7f%2BMCH7QfEh1CIoY185fZ7SPrJRs1oO4gFjL7XuMV9aqvG1gNJ9hFO790YpadY%2BDDBzCf0YTlW%2BA7UHOfIsL8KKxRiNJAnB4lOrvX3iZ8AvffIxbzq1zFHP%2BxeTw3UQOLQx9DfSsqjMcwlUKv%2FJ3XV28qTC4HxtAooAwkcLxgYQ906NkF3BSQoQyDeK7S7mi3NeRzxc7WP1KAt0aBpyk3T4cCHLl3tOrKCynQiN4QgaFklEBQU0Gf9EN8BaBceSV58G7GPQKJ5bh1VtZ3lpxbTUSsaOBg12cfzfPTLoKsSRJziV5Zdq%2BonaY9BrnEhQiYeItDjg0wPJmt%2BWuQUguu%2FOZPmrbOfyeqUZ6ndFvcds1pXNizctDbKCxEKJCbqtNo4cgjaqYaDzKCVtp96GQQp4JdEEQafeNlg6EBr%2BLeF4xWJt%2BT5V0e283EkvZu6s4BE8hljZez2wb3Q7D7S5Tmce6A2n8GQQ3FoWx24djtiwezVxFB%2F%2FkxRzzzvZE9Hsw3BijzqIfd2iKLbmil2ZY5IgvndRjua%2BWFtNMmE%2Bb5jW5k5IL8eAq3sg1ExnqW39UDu5tLbyx54e%2B70arEqboBBHhbv%2BqPpYMGnHQvevJJHExqAAQ7fmxoMVJD%2F0cvAn7UfB8Wwe2CKuR4PiuG3wrNvhAe4aQu6%2FZ92js8QD1p1Q94EBO6dtVnl5OjU0c5%2BBda8mPA1SAkYZA6NhZSoiVzFOaJ3jckvsOaRoYl0R3gJH%2FWTIGVsqG%2Fqa%2FhcYy%2BrZZDlDJvc2ewCY1MwzmAd6hz5RDARIAA%3D';
                WSAudioPlayer.instance.play(url, () {

                  print('====');
                },);

                // var page = TestPage1(pageName: '$pageName  1232');
                // // Get.global(10001).currentState?.push(newCommonPageRouteBuilder(page));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) {
                //     return page;
                //   }),
                // );
              },
            ),
            ElevatedButton(onPressed: (){
              WSAudioPlayer.instance.stop();
            }, child: Text('Stop')),
            ElevatedButton(onPressed: (){
              AudioUtil().test();
            }, child: Text('Merge')),
          ],
        ),
      ),
    );
  }


  static PageRouteBuilder newCommonPageRouteBuilder(Widget widget,
      {Widget Function(BuildContext ctx, Animation<double> one, Animation<double> two, Widget child)? transition}) {
    return PageRouteBuilder(
        pageBuilder: (ctx, one, two) => widget, transitionsBuilder: transition ?? slideTransitionRTL);
  }

  static SlideTransition slideTransitionRTL(ctx, one, two, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(one),
      child: child,
    );
  }
}


