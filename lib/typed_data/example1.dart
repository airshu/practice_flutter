import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void main() {

  print(1 << 8);
  int n = (1 << 63) - 1; //能保存的最大整数
  print(n);


  List<int> data = [102, 111, 114, 116, 121, 45, 116, 119, 111, 0];
  Uint8List bytes = Uint8List.fromList(data);
  print(bytes);

  data = [3, 256, -2, 2348738473];
  bytes = Uint8List.fromList(data);
  print(bytes);

  ByteBuffer byteBuffer = bytes.buffer;
  print(byteBuffer);
  ByteData byteData = byteBuffer.asByteData();
  ByteData bd = ByteData.view(byteBuffer);
  print(byteData.hashCode);
  print(bd.hashCode);
  print(byteData == bd);
  print(byteBuffer.asUint8List());
  print(byteBuffer.asUint16List());
  print(byteBuffer.asUint32List());
  print(byteData);


  data = [3, 256, -2, 2348738473];
  print(Uint8ClampedList.fromList(data)); // [3, 255, 0, 255]



  test1();
  test2();
  test3();
}

void test1() {
  Uint8List bytes = Uint8List.fromList([0, 1, 2, 3]);
  ByteBuffer byteBuffer = bytes.buffer;
  Uint32List thirtytwoBitList = byteBuffer.asUint32List();
  print(thirtytwoBitList);
}

/// 字符串、Uint8List类型转换
void test2() {
  print(2020.toRadixString(16).padLeft(4, '0'));
  print(2020.toRadixString(2));
  print('hello😎'.runes);
  print('hello😎'.codeUnits);

  var encoded = utf8.encode('Hello😎');
  print(encoded.runtimeType); //Uint8List
  print(encoded);

  print(utf8.decode(encoded));

}

void test3() {

  ByteData byteData = ByteData(3);
  byteData.setInt8(0, 100);
  // byteData.setInt16(0, 100);
  // byteData.setInt32(0, 100);
  // byteData.setInt64(0, 100);
  // byteData.setInt32(1, 2);
  // byteData.setInt32(2, 3);
  // byteData.setInt32(3, 4);
  // byteData.setFloat64(4, 3.14);

  // print(byteData.getInt32(0)); // 输出: 42
  // print(byteData.getFloat64(4)); // 输出: 3.14
  print(byteData.buffer.asUint8List());
  print(byteData.buffer.asUint16List());
  print(byteData.buffer.asUint32List());
  print(byteData.buffer.asUint64List());

  // var file = File('data.bin');
  // var data = file.readAsBytesSync();
  // var byteData = ByteData.view(data.buffer);
}