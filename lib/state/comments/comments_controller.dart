import 'package:flutter_demo_project/data/demo_api.dart';
import 'package:flutter_demo_project/view/_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_controller.g.dart';

@riverpod
class CommentsController extends _$CommentsController {
  @override
  Future<List<CommentVM>> build(int? id) async {
    if (id != null) {
      var list = await ref.read(demoApiProvider.notifier).fetchComments(id);
      List<CommentVM> commentsList = list.map((element) {
        return CommentVM.fromDto(element);
      }).toList();
      return commentsList;
    } else {
      return [];
    }
  }
}
