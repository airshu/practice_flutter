
import 'dart:io';

void main(){

  new File(r"C:\Users\86139\Downloads\010editor.zip").readAsBytes().then((_){
    print("future");
  });

  //写这个文件
  var dst = new File(r"C:\Users\86139\Downloads\010editor1.zip");
  var write = dst.openWrite();
  Stream<List<int>> stream = new File(r"C:\Users\86139\Downloads\010editor.zip").openRead();
  var listen = stream.listen((s){
    print("stream");
    write.add(s);
  });

  //替代掉listen的方法
//  listen.onData((s){
//    print("strema2");
//  });
//  listen.onDone((){
//    print("读完整个文件");
//  });
//  listen.pause();
//  listen.resume();


}
