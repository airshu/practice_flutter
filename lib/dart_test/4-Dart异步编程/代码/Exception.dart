void main() {
  try {
    test();
  } on Exception catch (e, s) {
    print(e);
  } on String catch (e) {
    print(e);
  } finally {
    print('finally');
  }
}

void test() {
  throw 'aaa';
}
