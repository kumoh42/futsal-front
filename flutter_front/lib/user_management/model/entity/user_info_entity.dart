import 'package:json_annotation/json_annotation.dart';

part 'user_info_entity.g.dart';

@JsonSerializable()
class UserInfo {
  final String member_member_srl;
  final String member_user_name;
  final String member_phone_number;
  final String member_permission;
  final String circle_circle_name;
  final String major_major_name;
  UserInfo({
    required this.circle_circle_name,
    required this.major_major_name,
    required this.member_member_srl,
    required this.member_permission,
    required this.member_phone_number,
    required this.member_user_name,
  });

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
