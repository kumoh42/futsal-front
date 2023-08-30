import 'package:json_annotation/json_annotation.dart';

part 'send_message_request_dto.g.dart';

@JsonSerializable()
class SendMessageRequestDto {
  String email;
  String text;

  SendMessageRequestDto({
    required this.email,
    required this.text,
  });

  Map<String, dynamic> toJson() => _$SendMessageRequestDtoToJson(this);

  factory SendMessageRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestDtoFromJson(json);
}
