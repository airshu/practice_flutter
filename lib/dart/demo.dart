
import 'dart:async';

void main() {
  // Symbol lib = Symbol("foo_lib");


  Future.delayed(Duration.zero, () {
    print("delayed");
  });
  Timer.run(() { print("executed"); });
  Future.microtask(() {
    print("microtask");
  });
  Future.sync(() {
    print("sync");
  });

  Zone.current.createTimer(Duration.zero, (){
    print("Zone createTimer");
  });

  Zone.current
      .createTimer(Duration.zero, Zone.current.bindCallbackGuarded((){
    print("Zone createTimer bindCallbackGuarded");
  }));

}