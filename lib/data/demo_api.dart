import 'package:flutter_demo_project/data/dto/posts/post_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '_data.dart';

part 'demo_api.g.dart';

@riverpod
class DemoApi extends _$DemoApi {
  @override
  Future<List<PostDto>> build() async {
    return fetchPosts();
  }

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

  Future<PostDto> getSinglePost(int id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return PostDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<bool> deleteSinglePost(int id) async {
    final response = await http
        .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editSinglePost(int id) async {
    final response = await http
        .put(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<CommentDto>> fetchComments(int id) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id/comments'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => CommentDto.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
