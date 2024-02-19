import 'dart:async';

import 'dart:io';


main() async {

  // testDelayedTask();
  // testWait();
  // return;

  // Future(()=>print('test'));// 将任务添加到Event队列
  // Future.delayed(Duration(milliseconds: 1000)).then((value) => print('test2 delay 1s'));
  // Future.microtask(() => print('Future.microtask'));// 调度任务，优先级高，但会阻塞Event任务
  // Future.sync(() => print('sync')).catchError((e){
  //   print(e);
  // });




  // Timer.periodic(Duration(milliseconds: 500), (timer) {
  //   print('=======${DateTime.now()}');
  // });

  // scheduleMicrotask((){
  //   print('=====');
  // });

  test1();
  await test2();
  test1();
}

void test1() {
  print('====>>>>>>test1  ${DateTime.now()}');
}

Future test2() async {
  print('test2 start');
  Future.delayed(Duration(milliseconds: 300)).then((value) {
    print('==============');
  });
  print('test2 end');

}

void testWait() {
  Future future1 = Future(()=>print(1));
  Future future2 = Future(()=>print(2));
  Future future3 = Future(()=>print(3));
  Future future = Future.wait([future1, future2, future3]);
  future.then((value) => print('>>> $value'));
  print('end');
}


void testDelayedTask() {
  print('start');
  Future.delayed(Duration(seconds: 1), (){
    print('task delay');
  });

  Future((){
    sleep(Duration(seconds: 3));
    print('3s task');
  });

  print('stop');
}