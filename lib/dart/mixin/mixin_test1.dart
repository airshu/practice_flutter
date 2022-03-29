
/// 最简单的用法，相当于继承
main() {
  Foo().name();
}

class Foo with FooMixin {
  // void name() {
  //   super.name();
  //   print('Foo');
  // }


}

mixin FooMixin {
  void name() {
    print('FooMixin');
  }
}
