import 'package:flutter_demo_project/data/dto/posts/post_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'demo_api.g.dart';

@riverpod
class DemoApi extends _$DemoApi {
  Future<List<PostDto>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => PostDto.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<PostDto>> build() async {
    return fetchPosts();
  }

  Future<PostDto> getPost(int id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return PostDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
