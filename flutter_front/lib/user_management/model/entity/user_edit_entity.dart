import 'package:json_annotation/json_annotation.dart';

part 'user_edit_entity.g.dart';

@JsonSerializable()
class UserEditEntity {
  String memberName;
  String phoneNumber;
  int circleSrl;
  int majorSrl;
  UserEditEntity({
    required this.circleSrl,
    required this.majorSrl,
    required this.memberName,
    required this.phoneNumber,
  });
  Map<String, dynamic> toJson() => _$UserEditEntityToJson(this);
}
