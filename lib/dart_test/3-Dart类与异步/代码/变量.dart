void test(a) {}

void main() {
//     Object i = "Lance";
//     var j = "Lance";
////     j = 100;

  // var 在声明的变量赋值那一刻，就决定了它是什么类型。
//    var j;
//    j = "Lance";
//    j = 100;

  //
//    dynamic z = "Lance";
//    z = 100;

//    Object i = 1;
//    var j = 1;
//    dynamic z = 1;

  final i = 1;
  //i  =2;

  const j = 1;
  //j = 2;

  //因为i是运行时确定，所以不能给编译时候就要确定的变量赋值
//  const z = i;

  //可以使用另一个编译时确定的变量 给它赋值
  const z = j + 1;
  //
  final w = z;



}
