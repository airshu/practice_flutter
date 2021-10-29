
/// 混入测试
///
///
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
}

class TestBase {
  TestBase() {
    print('TestBase');
    initInstances();
  }

  void initInstances() {
    print('TestBase init');
  }
}

mixin TestRendererBinding on TestBase {
  @override
  void initInstances() {
    super.initInstances();
    print('TestRendererBinding init');
  }

  String get renderView => "renderView";
}

mixin TestWidgetsBinding on TestBase, TestRendererBinding {
  static TestWidgetsBinding? get instance => _instance;
  static TestWidgetsBinding? _instance;

  @override
  void initInstances() {
    super.initInstances();//如果不调用super，则前面的不会执行
    _instance = this;
    print('TestWidgetsBinding init');
  }
}

///
class TestWidgetsFlutterBinding extends TestBase with TestRendererBinding, TestWidgetsBinding {
  static void ensureInitialized() {
    if (TestWidgetsBinding.instance == null) TestWidgetsFlutterBinding();
    print('ensureInitialized ${TestWidgetsBinding.instance}');

    print(TestWidgetsBinding.instance!.renderView);

  }


}
