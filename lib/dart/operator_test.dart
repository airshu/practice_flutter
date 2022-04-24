
/// 常用操作符
///
///
main() {
  int a = 2;
  a++;
  print('a++=$a');
  ++a;
  print('++a=$a');
  a--;
  print('a--=$a');
  --a;
  print('--a=$a');
  a == 2;


  // 条件表达式
  int? b;
  b ??= 2;//如果b为空则赋值
  print('b*=3=${b *= 3}');
  print('b >>= 1=${b >>= 1}');
  int c = b == 2 ? 3 : 4;


  a + b;
  a * c;
  a / c;
  a = 7;
  print('a ~/ b=${a ~/ b}');//返回除完后结果的整数部分
  print('a % b=${a % b}');//取模

  print('a==b=${a==b}');
  print('a>=b=${a>=b}');
  print('a<=b=${a<=b}');


  print('a is int=${a is int}');
  print('a is int=${a is! int}');
  print('a as int=${a as int}');

  print('${a == 2 && b == 3}');
  print('${a == 2 || b == 3}');


  // 位运算
  final value = 0x22;
  final bitmask = 0x0f;

  print((value & bitmask)  == 0x02);  // 与
  print((value & ~bitmask) == 0x20);  // 与非
  print((value | bitmask)  == 0x2f);  // 或
  print((value ^ bitmask)  == 0x2d);  // 异或
  print((value << 4)       == 0x220); // 左移
  print((value >> 4)       == 0x02);  // 右移



}