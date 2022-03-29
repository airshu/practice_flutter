


main() {
  var dog = Dog();
  dog.run();
  dog.cry();


  var cat = Cat();
  cat.run();
  cat.cry();

  var car = Car();
  car.printName();
  car.open();

  var airplane = Airplane();
  airplane.printName();
}

abstract class Animal {

  void cry();

  void run() {
    print('Animal run');
  }
}

/// 使用implements，需要实现所有的方法
class Dog implements Animal {

  @override
  void cry() {
    print('Dog cry');
  }

  @override
  void run() {
    print('Dog run');
  }


}

class Cat extends Animal {
  @override
  void cry() {
    print('Cat cry');
  }

}


class Machine {
  void printName() {
    print('My name is Machine ');
  }
}

abstract class Door {
  void open();
}

/// 实现多个类
class Car implements Machine, Door {
  @override
  void printName() {
    print('My name is Car');
  }

  @override
  void open() {
    print('Open Car door');
  }
}

class Airplane extends Machine {

  @override
  void printName() {
    print('My name is Airplane');
  }
}