import 'dart:convert';

import 'package:flutter_demo_project/data/demo_api.dart';
import 'package:flutter_demo_project/state/_state.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'posts_controller.g.dart';

@riverpod
class PostsController extends _$PostsController {
  @override
  Future<List<PostVM>> build() async {
    var list = await ref.read(demoApiProvider.future);
    List<PostVM> postsList = list.map((element) {
      return PostVM(
          body: element.body,
          id: element.id,
          title: element.title,
          userId: element.userId);
    }).toList();
    return postsList;
  }

  Future<void> refresh() async {
    var connectivity = ref.watch(networkStatusProvider);
    if (connectivity) {
      var list = await ref.read(demoApiProvider.future);
      List<PostVM> postsList = list.map((element) {
        return PostVM(
            body: element.body,
            id: element.id,
            title: element.title,
            userId: element.userId);
      }).toList();
      update((p0) => postsList);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? postsJson = prefs.getString('posts');
      if (postsJson != null) {
        final List<PostVM> list = (json.decode(postsJson) as List)
            .map((i) => PostVM.fromJson(i))
            .toList();
        update((p0) => list);
      }
    }
  }
}
