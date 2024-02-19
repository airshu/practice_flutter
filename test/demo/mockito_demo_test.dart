import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'counter.dart';
import 'mockito_demo_test.mocks.dart';

/// 使用mockito测试示例
@GenerateMocks([Client])
void main() {
  Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final Counter counter = Counter();
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();
      //mock返回数据
      when(client.get(uri)).thenAnswer((_) async => Response('{"title": "Test"}', 200) );
      Post post = await counter.fetchPost(client);
      expect(post.title, "Test");
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(uri)).thenAnswer((_) async => Response('Not Found', 404));
      expect(counter.fetchPost(client), throwsException);
    });
  });
}
