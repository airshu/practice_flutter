void main(){
	print("Hello,Dart!");


	int i = 1111111121212121211;
	print(i.bitLength);

	double d = 12321;
	print('${d.runtimeType} ======= ${d}');

	List<String> list = ['1', '2', '3'];

	for(var item in list) {
		print(item);
	}


	List<int> list2 = const [1,2,3];
	// error
	// list2.add(5);
	list2 = [1,2,3,4];
	print(list2);

	const List<int> list3 = [4,5,6];
	list3.where((element) => element>3);
	// list3.add(7);
	// error
	// list3 = [1,2,3,4];
	print(list3);

	Map<int, int> map = {1:11, 2:22};
	map[3] = 33333;
	print(map);
	print(map[1]);
	print(map.keys);
	print(map.values);
	for( var item in map.entries) {
		print(item);
	}

	Set<String> set = {'aaa', 'bbb'};
	for(var item in set) {
		print(item);
	}
	set.forEach((element) {
		print(element);
	});

	set.clear();

	var b = Symbol("b");
	print(#b == b); ///true


}