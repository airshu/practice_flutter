



import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  debugPrintBuildScope = true;
  runApp(
    MaterialApp(
      home: Scaffold(body: ProviderRoute()),
    ),
  );
}

/// 状态管理demo
/// 运用inheritedwidget、changenotifier
///


class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {

  int count = 100;
  CartModel cartModel = CartModel();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: cartModel,
        child: Builder(builder: (context) {
          print('11111build');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<CartModel>(
                builder: (context, cart) {
                  return Text("总价: ${cart!.totalPrice}");
                },
              ),
              Text('====$count'),
              Builder(builder: (context) {
                print('-=-=-=-=-=-=');
                return Text('======');
              },),
              Builder(builder: (context){
                print("#######RaisedButton build");
                return TextButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    count++;
                    ChangeNotifierProvider.of<CartModel>(context, listen: true)?.add(Item(20.0, 1));
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}



class Item {

  double price;
  int count;

  Item(this.price, this.count);
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (value, item) => value + item.count* item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}




class InheritedProvider<T> extends InheritedWidget {

  InheritedProvider({required this.data, required Widget child}) : super(child: child);

  final T data;


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {

    return true;
  }

}


class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {


  final Widget child;
  final T data;

  @override
  _ChangeNotifierProvierState<T> createState() {
    return _ChangeNotifierProvierState<T>();
  }

  ChangeNotifierProvider({Key? key, required this.child,required this.data});

  static T of<T>(BuildContext context, {bool listen=true}) {
    // final type = _typeOf
    // var provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    // var provider = context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()!.widget as InheritedProvider;

    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget
    as InheritedProvider<T>;

    print('#########################provider=$provider');
    return provider!.data;
  }
}

class _ChangeNotifierProvierState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  void update() {
    setState(() {

    });
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if(widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }

}


// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}
