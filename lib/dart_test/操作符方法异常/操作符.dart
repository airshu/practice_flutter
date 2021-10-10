void main() {
  /**
   * 类型判断操作符
   */
  num j = 1;
  //类型转换 不支持 java的： (int)强转写法
  int i = j as int;

  Object i1 = 1;
  //没有java的 instantof ，需要使用is
  if (i1 is int) {}
  //不属于int类型则命中if
  if (i1 is! int) {}

  /**
   * 赋值操作符
   */
  String? k = null;

  //java保证k后续使用一定不为null
  if (null == k) {
    k = "123";
  }

  //??= 安全赋值，如果k有值，这句话就当他不存在。如果没值就赋值456
  k ??= "456";
  print(k);

  /**
   * 条件表达式
   */
  k = null;
  var v = k ?? "789";
  print(v);

  /**
   * 级联操作符
   */
  new Builder()
    ..a()
    ..b();

  /**
   *  安全操作符
   */
  String? str;
  //如果str为null，就返回null
  print(str?.length);
}

class Builder {
  void a() {}

  void b() {}
}
