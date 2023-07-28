import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
    final String name;
    UserEntity({required this.name});

    Map<String, dynamic> toJson() => _$UserEntityToJson(this);

    factory UserEntity.fromJson(Map<String, dynamic> json) =>
        _$UserEntityFromJson(json);
}