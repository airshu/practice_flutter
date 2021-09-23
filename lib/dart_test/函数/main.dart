/// 必选参数
/// 可选参数
class RequiredParamsClass {
  int? key;
  late String name;

  RequiredParamsClass({int? key, required String name}){
    this.key = key;
    this.name = name;
  }

  /// 缺省参数
  void enableFlags({bool bold = false, bool hidden = false}) {}


}

class SquareBracketsClass {
  late int x;
  late int y;
  SquareBracketsClass([int x=1, int y=2]) {
    this.x = x;
    this.y = y;
  }
}



void printElement(int element) {
  print(element);
}

bool topLevel = true;


main() {
//   var requiredParamsClass = RequiredParamsClass(name: '必填的Name');
//   requiredParamsClass.enableFlags(bold: true);
//
//   var squareBracketClass = SquareBracketsClass(3);
//   var squareBracketClass2 = SquareBracketsClass(3, 6);
//
//   // 函数作为参数
//   var list = [1, 2, 3];
// // Pass printElement as a parameter.
//   list.forEach(printElement);
//
//
// // 变量作用域
//   var insideMain = true;
//
//   void myFunction() {
//     var insideFunction = true;
//
//     void nestedFunction() {
//       var insideNestedFunction = true;
//
//       assert(topLevel);
//       assert(insideMain);
//       assert(insideFunction);
//       assert(insideNestedFunction);
//     }
//   }

//字符串
  var a  = "my name is " "lance";

  var array = [23,45,678,9,32,2];
  for(int i=0;i<array.length;i++) {
    for(int j=i+1;j<array.length;j++) {
      if(array[i]>array[j]) {
        swap(array, i, j);
      }
    }
  }
  print(array);



}

void swap(List array, int i, int j) {
  var temp = array[i];
  array[i] = array[j];
  array[j] = temp;
}
