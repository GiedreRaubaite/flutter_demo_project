import 'package:flutter_demo_project/state/network_connectivity/network_connectivity_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '_data.dart';

part 'demo_api.g.dart';

@riverpod
class DemoApi extends _$DemoApi {
  @override
  Future<List<PostDto>> build() async {
    return fetchPosts();
  }

  Future<List<PostDto>> fetchPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivity = ref.watch(networkStatusProvider);
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        await prefs.setString('posts', response.body);
        return (json.decode(response.body) as List)
            .map((i) => PostDto.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      if (!connectivity) {
        String? offlineList = prefs.getString('posts');
        if (offlineList != null) {
          return (json.decode(offlineList) as List)
              .map((i) => PostDto.fromJson(i))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception("Oops... Something went wrong");
      }
    }
  }

  Future<PostDto> getSinglePost(int id) async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
      if (response.statusCode == 200) {
        return PostDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception("Oops... Something went wrong");
    }
  }

  Future<bool> deleteSinglePost(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editSinglePost(int id, PostDto post) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        body: jsonEncode(post),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<CommentDto>> fetchComments(int id) async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/$id/comments'));
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => CommentDto.fromJson(i))
            .toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception("Oops... Something went wrong when fetching comments");
    }
  }
}
