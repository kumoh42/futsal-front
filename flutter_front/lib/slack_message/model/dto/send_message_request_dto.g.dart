// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequestDto _$SendMessageRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SendMessageRequestDto(
      email: json['email'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$SendMessageRequestDtoToJson(
        SendMessageRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'text': instance.text,
    };
