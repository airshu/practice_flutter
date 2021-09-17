mixin A {
  test() {
    print('A');
  }
}
mixin B {
  test() {
    print('B');
  }
}

class C {
  test() {
    print('C');
  }
}

class D extends C with A, B {}

class E extends C with B, A {}

/// 重载运算符
class Rectangle {
  int width;
  int height;

  Rectangle(this.width, this.height) {}

  @override
  bool operator ==(dynamic other) {
    if (other is! Rectangle) {
      return false;
    }
    Rectangle temp = other;
    return (temp.width == width && temp.height == height);
  }

  @override
  Rectangle operator +(dynamic other) {
    if (other is! Rectangle) {
      return this;
    }
    Rectangle temp = other;
    return new Rectangle(this.width + temp.width, this.height + temp.height);
  }
}



/// 抽象类
abstract class Animal{
  late String name;  //数据
  void display(){  //普通函数
    print("名字是:${name}");
  }
  /// 可以不用abstract修饰
  void eat(); //抽象函数
}

class Dog extends Animal{
  /// 实现抽象方法
  @override
  void eat() { //实现抽象函数
    print("eat");
  }
}


/// Dart中没有interface关键字，可以将类（是否为抽象无关）当做隐式接口直接使用，当需要使用接口时，可以声明类来代替。
abstract class swimable{ //抽象类作为接口
  void swim();
}

class walkable{ //普通类作为接口
  void walk(){}
}

class Dog2 extends Animal implements swimable, walkable{
  @override
  void eat() {
    print("eat");
  }
  @override
  void swim() {
    print("swim");
  }
  @override
  void walk() {
    print("walk");
  }
}

class Walker {
  void walk() {
    print("I'm walking");
  }
}


class Swimmer {
  void swim() {
    print("I'm swimming");
  }
}
class Flyer{
  void fly() {
    print("I'm flying");
  }
}


class Mammal {

}

class Bird {

}


class Cat extends Mammal with Walker {}
class Dove extends Bird with Walker, Flyer {}

void main() {
  // D d = D();
  // d.test();

  // E e = E();
  // e.test();

  Cat cat = Cat();
  cat.walk();
  Dove dove = Dove();
  dove.fly();
  dove.walk();
}
