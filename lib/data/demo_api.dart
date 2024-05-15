import 'package:flutter_demo_project/data/dto/posts/post_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<PostDto>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    print(jsonDecode(response.body));
    Iterable result = json.decode(response.body);
    print(result);
    List<PostDto> posts;
    posts = (json.decode(response.body) as List)
        .map((i) => PostDto.fromJson(i))
        .toList();
    print(posts);
    return posts;
    // result.map((e) => PostDto.fromJson(e as Map<String, dynamic>)).toList();
    // return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
