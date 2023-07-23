import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
    UserEntity();

    Map<String, dynamic> toJson() => _$UserEntityToJson(this);

    factory UserEntity.fromJson(Map<String, dynamic> json) =>
        _$UserEntityFromJson(json);
}