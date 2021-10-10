void main() {
  var point = Point(1, 2);
  print(point._x);

  var p2 = Point.empty();
  print(p2._x);

  var p3 = Point.X(5);
  print(p3._x);

  var p4 = Point.fromMap({'x': 1, 'y': 9});
  print('${p4._x} --- ${p4._y}');

  var ip1 = const ImutablePoint(1, 1);
  var ip2 = const ImutablePoint(1, 1);
  print(ip1.hashCode == ip2.hashCode);
  print(ip1 == ip2);

  Child();

  RoomManager.getInstance();
}


class Parent{
  Parent(){
    print('In Parent\'s constructor.');
  }
}

class Child extends Parent{
  Child(){
    print('In Child\'s constructor.');
  }
}


class Point {
  // 私有属性
  int? _x;
  int? _y;

  Point(this._x, this._y);

  // 命名构造方法
  Point.X(this._x);

  Point.empty() {
    _x = 0;
    _y = 0;
  }

  // 参数初始化列表
  Point.fromMap(Map map)
      : _x = map['x'],
        _y = map['y'];
}

class View {
  View(int context, int attr);

  // 重定向构造函数
  View.a(int context) : this(context, 0);
}

class ImutablePoint {
  final int x;
  final int y;

  //常量构造方法
  const ImutablePoint(this.x, this.y);
}


class RoomManager {


  static RoomManager? _instance;


  //工厂构造方法
  factory RoomManager.getInstance() {
    if(_instance == null) {
      _instance = RoomManager._newInstance();
    }
    return _instance!;
  }

  RoomManager._newInstance();
}