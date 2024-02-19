import 'dart:convert';

import 'package:http/http.dart' as http;

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;

  Future<Post> fetchPost(http.Client client) async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class Post {
  int id;
  int userId;
  String title;
  String body;

  Post({required this.id, required this.userId, required this.title, required this.body});

  static fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'] ?? 0, userId: json['userId'] ?? 0, title: json['title'] ?? '', body: json['body'] ?? '');
  }
}
