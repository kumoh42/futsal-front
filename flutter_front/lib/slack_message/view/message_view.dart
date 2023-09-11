import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/slack_message/component/messaging_box.dart';
import 'package:flutter_front/slack_message/viewmodel/message_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageView extends ConsumerWidget {
  MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(messageViewModelProvider);
    return MessagingBox(
      controller: viewmodel.messageBoxController,
      title: "금오사이 문의하기",
      backgroundColor: CustomColor.mainColor,
      bodyTextStyle: kTextReverseStyleMiddle,
      textFieldColor: CustomColor.backgroundMainColor,
      textFiledTextStyle: kTextMainStyleSmall.copyWith(
        fontWeight: FontWeight.normal,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.mainColor,
          borderRadius: BorderRadius.circular(kBorderRadiusMiniSize),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "문의 사항을 남겨주시면 금오사이 운영진에게 전송됩니다.\n"
              "아래 작성한 메일로 응답이 갈 예정입니다.\n"
              "응답에는 오랜 시간이 소요될 수 있습니다.",
              style: kTextReverseStyleSmall,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
