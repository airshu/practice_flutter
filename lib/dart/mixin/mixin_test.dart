/// mixin多个，链式结构
///
///
main() {

  // A -> MB -> MA -> S 如果不主动调用上一级，则会终止，
  A().fun();
  // B().fun();
}

class S {
  fun() {
    print('A');
  }
}

mixin MA on S {
  fun() {
    super.fun();
    print('MA');
  }

  void log() {
    print('MA log');
  }
}
mixin MB on S {
  fun() {
    super.fun();
    print('MB');
  }

  void log() {
    print('MB log');
  }
}

class A extends S with MA, MB {}

class B extends S with MB, MA {}
