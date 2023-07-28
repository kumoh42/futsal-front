import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
    String user_id;
    String user_password;

    LoginRequestDto({required this.user_id, required this.user_password});

    Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

    factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
        _$LoginRequestDtoFromJson(json);
}