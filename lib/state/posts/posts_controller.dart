import 'package:flutter_demo_project/data/demo_api.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    var list = await ref.read(demoApiProvider.future);
    List<PostVM> postsList = list.map((element) {
      return PostVM(
          body: element.body,
          id: element.id,
          title: element.title,
          userId: element.userId);
    }).toList();
    update((p0) => postsList);
  }
}
