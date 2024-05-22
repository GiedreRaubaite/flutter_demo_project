// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostVMImpl _$$PostVMImplFromJson(Map<String, dynamic> json) => _$PostVMImpl(
      userId: (json['userId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$$PostVMImplToJson(_$PostVMImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
