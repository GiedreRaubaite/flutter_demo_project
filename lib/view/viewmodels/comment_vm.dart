import 'package:flutter_demo_project/data/_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_vm.freezed.dart';

@freezed
class CommentVM with _$CommentVM {
  const factory CommentVM(
      {int? postId,
      int? id,
      String? name,
      String? email,
      String? body}) = _CommentVM;

  factory CommentVM.fromDto(
    CommentDto dto,
  ) {
    return CommentVM(
        postId: dto.postId,
        id: dto.id,
        name: dto.name,
        email: dto.email,
        body: dto.body);
  }
}
