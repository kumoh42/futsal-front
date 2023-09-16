import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/titled_text.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationCancelDialog extends StatelessWidget {
  final List<ReservationStatusEntity> entities;
  final Future Function(ReservationStatusEntity) onPressed;

  const ReservationCancelDialog({
    Key? key,
    required this.entities,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(child: Text('예약 취소 확인')),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      titleTextStyle: kTextMainStyleLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kBorderRadiusSize),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: width * 0.3,
          constraints: const BoxConstraints(minWidth: 500, maxWidth: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TitledText(title: '아이디', text: entity.member.id),
              // const SizedBox(height: kPaddingMiddleSize),
              // TitledText(title: '이름', text: entity.member.name),
              // const SizedBox(height: kPaddingMiddleSize),
              // Row(
              //   children: [
              //     Expanded(
              //         child:
              //             TitledText(title: '연락처', text: entity.member.phone)),
              //     const SizedBox(width: kPaddingMiddleSize),
              //     Expanded(
              //         child:
              //             TitledText(title: '이메일', text: entity.member.email)),
              //   ],
              // ),
              const SizedBox(height: kPaddingMiddleSize),
              for (var e in entities)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitledText(
                      title: '예약 날짜',
                      text: defaultDateFormat.format(e.date),
                    ),
                    const SizedBox(width: kPaddingLargeSize),
                    TitledText(
                      title: '예약 시간',
                      text: '${e.time}시~${e.time + 2}시',
                    ),
                  ],
                ),
              const SizedBox(height: kPaddingMiddleSize),
              const Text('예약을 취소하시겠습니까?', style: kTextMainStyleSmall),
              const SizedBox(height: kPaddingMiddleSize),
              const Text(
                '사전 안내 없이 임의로 취소하여 문제가 발생할 경우\n\'금오사이\'에서는 챔임지지 않습니다.',
                style: kTextMainStyleSmall,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await onPressed(entities[0]);
            if (context.mounted) Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kMainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingLargeSize,
              vertical: kPaddingMiddleSize,
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.check),
              Expanded(
                child: Center(
                  child: Text(
                    '확인 및 예약 취소',
                    style: kTextMainStyleMiddle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
