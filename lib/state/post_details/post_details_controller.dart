import 'package:flutter_demo_project/data/demo_api.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_details_controller.g.dart';

@riverpod
class PostDetailsController extends _$PostDetailsController {
  @override
  Future<PostVM> build(int id) async {
    var post = await ref.read(demoApiProvider.notifier).getPost(id);
    PostVM postDetails = PostVM(
        body: post.body, id: post.id, title: post.title, userId: post.userId);

    return postDetails;
  }
}
