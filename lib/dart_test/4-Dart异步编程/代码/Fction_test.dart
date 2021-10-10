void foo() {
  print('foo');

  print(add());
  print(add(i: 1));
  print(add(i: 2, j: 4));
}

typedef void onclick(String result);

main() {
  Function fun = foo;
  fun();

  addListener((result) {
    print('===== ${result}');
  });

}

addListener(onclick listener) {
  listener('success');
}

int add({int? i, int? j}) {
  if(i == null || j == null){
    return 0;
  }
  return i + j;
}
