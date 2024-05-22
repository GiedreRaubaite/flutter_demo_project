import 'package:flutter_demo_project/data/dto/posts/post_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_vm.freezed.dart';
part 'post_vm.g.dart';

@freezed
class PostVM with _$PostVM {
  const factory PostVM({int? userId, int? id, String? title, String? body}) =
      _PostVM;

  factory PostVM.fromJson(Map<String, dynamic> json) => _$PostVMFromJson(json);

  factory PostVM.fromDto(
    PostDto dto,
  ) {
    return PostVM(
        id: dto.id, userId: dto.userId, title: dto.title, body: dto.body);
  }
}
