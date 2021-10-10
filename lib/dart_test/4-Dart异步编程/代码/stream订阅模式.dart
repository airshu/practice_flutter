
import 'dart:io';

void main(){
  Stream<List<int>> stream = new File(r"C:\Users\86139\Downloads\010editor.zip").openRead();
  //两个订阅者会报错
//  var listen = stream.listen((s){
//
//  });

//  stream.listen((s){
//
//  });


  //广播模式  : 可以多订阅
  var broadcastStream = stream.asBroadcastStream();
  broadcastStream.listen((_){
    print("listen1");

  });
  broadcastStream.listen((_){
    print("listen2");
  });
//
//  broadcastStream.listen((_){});
//  broadcastStream.listen((_){});
//  broadcastStream.listen((_){});
}
