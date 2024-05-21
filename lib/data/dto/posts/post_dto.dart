import 'package:flutter_demo_project/view/viewmodels/_viewmodels.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
class PostDto with _$PostDto {
  const factory PostDto({int? userId, int? id, String? title, String? body}) =
      _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  factory PostDto.fromVM(
    PostVM postVM,
  ) {
    return PostDto(
        id: postVM.id,
        userId: postVM.userId,
        title: postVM.title,
        body: postVM.body);
  }
}
