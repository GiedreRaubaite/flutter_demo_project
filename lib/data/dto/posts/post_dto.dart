import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

@freezed
class PostDto with _$PostDto {
  const factory PostDto({int? userId, int? id, String? title, String? body}) =
      _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
