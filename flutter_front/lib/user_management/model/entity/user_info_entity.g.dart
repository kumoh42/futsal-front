// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      circle_circle_name: json['circle_circle_name'] as String,
      major_major_name: json['major_major_name'] as String,
      member_member_srl: json['member_member_srl'] as String,
      member_permission: json['member_permission'] as String,
      member_phone_number: json['member_phone_number'] as String,
      member_user_name: json['member_user_name'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'member_member_srl': instance.member_member_srl,
      'member_user_name': instance.member_user_name,
      'member_phone_number': instance.member_phone_number,
      'member_permission': instance.member_permission,
      'circle_circle_name': instance.circle_circle_name,
      'major_major_name': instance.major_major_name,
    };
