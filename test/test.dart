// import 'dart:convert';

// // import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;

//   Post(
//       {required this.userId,
//       required this.id,
//       required this.title,
//       required this.body});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }

// Future<Post> fetchPost() async {
//   var http;
//   final response =
//       await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   if (response.statusCode == 200) {
//     // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // 만약 요청이 실패하면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }

// void main() {
//   var info = fetchPost();
//   print(info.hashCode);
// }
