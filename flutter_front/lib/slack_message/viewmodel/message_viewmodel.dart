import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/slack_message/component/messaging_box.dart';
import 'package:flutter_front/slack_message/model/service/message_service.dart';
import 'package:flutter_front/slack_message/model/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageViewModelProvider =
    ChangeNotifierProvider((ref) => MessageViewModel(ref));

class MessageViewModel extends ChangeNotifier {
  final Ref ref;
  late MessageState messageState;
  late MessagingBoxController messageBoxController;

  MessageViewModel(this.ref) {
    messageState = ref.read(messageServiceProvider);
    messageBoxController = MessagingBoxController(onSendClicked: sendMessage);
    ref.listen(messageServiceProvider, (previous, next) {
      if (previous != next) {
        messageState = next;
        if (messageState is ErrorState) {
          SnackBarUtil.showError((messageState as ErrorState).message);
        }
        if (messageState is SuccessState) {
          SnackBarUtil.showSuccess("문의사항이 성공적으로 전송되었습니다. 작성한 이메일을 통해 응답이 올 예정입니다.");
        }
        notifyListeners();
      }
    });
  }

  Future sendMessage(String email, String text) async {
    await ref
        .read(messageServiceProvider.notifier)
        .sendMessage(email: email, text: text);
  }
}
