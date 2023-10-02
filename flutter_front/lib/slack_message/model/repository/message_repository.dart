import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/slack_message/model/dto/send_message_request_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'message_repository.g.dart';

final messageRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MessageRepository(dio);
});

@RestApi()
abstract class MessageRepository {
  factory MessageRepository(Dio dio, {String baseUrl}) = _MessageRepository;

  @POST('/inquiry')
  @Headers({'accessToken': 'true'})
  Future sendMessage(@Body() SendMessageRequestDto sendMessageRequestDto);
}
