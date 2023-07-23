import 'package:json_annotation/json_annotation.dart';

part 'login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity {
  String accessToken;
  String refreshToken;

  LoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => _$LoginResponseEntityToJson(this);

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseEntityFromJson(json);
}
