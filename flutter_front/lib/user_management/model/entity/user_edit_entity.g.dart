// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEditEntity _$UserEditFromJson(Map<String, dynamic> json) => UserEditEntity(
      circleSrl: json['circleSrl'] as int,
      majorSrl: json['majorSrl'] as int,
      memberName: json['memberName'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserEditToJson(UserEditEntity instance) =>
    <String, dynamic>{
      'memberName': instance.memberName,
      'phoneNumber': instance.phoneNumber,
      'circleSrl': instance.circleSrl,
      'majorSrl': instance.majorSrl,
    };
