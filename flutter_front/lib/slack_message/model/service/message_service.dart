import 'package:dio/dio.dart';
import 'package:flutter_front/slack_message/model/dto/send_message_request_dto.dart';
import 'package:flutter_front/slack_message/model/repository/message_repository.dart';
import 'package:flutter_front/slack_message/model/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageServiceProvider =
StateNotifierProvider<MessageService, MessageState>((ref) {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return MessageService(messageRepository);
});

class MessageService extends StateNotifier<MessageState> {
  final MessageRepository messageRepository;

  MessageService(this.messageRepository) : super(MessageStateNone());

  Future sendMessage({required String email, required String text}) async {
    state = MessageStateLoading();
    try {
      await messageRepository
          .sendMessage(SendMessageRequestDto(email: email, text: text));
      state = MessageStateSuccess(null);
    } on DioException catch (e) {
      print(e);
      state = MessageStateError("메시지를 전송하는데 실패하였습니다.");
    } catch (e) {
      state = MessageStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}
