import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class ReservationCancelAllDialog extends StatefulWidget {
  final Future Function() onPressed;

  ReservationCancelAllDialog({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ReservationCancelAllDialog> createState() =>
      _ReservationCancelAllDialogState();
}

class _ReservationCancelAllDialogState
    extends State<ReservationCancelAllDialog> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: const Text('예약 긴급 중단'),
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
              Text('모든 예약을 긴급 중단하시겠습니까?', style: kTextMainStyleSmall),
              SizedBox(height: kPaddingMiddleSize),
              Text(
                '이에 대한 모든 책임은 예약 관리자에 있으며,\n금오사이 및 금오사이 기술팀은 긴급 중단에 대한 책임을 일절 지지 않습니다.',
                style: kTextMainStyleSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: kPaddingMiddleSize),
              Text(
                '반드시 서버 폭주, 예약 시간 설정 실수 등\n중대한 오류 상황에서만 사용하시기 바랍니다.',
                style: kTextMainStyleSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: kPaddingMiddleSize),
              CheckboxListTile(
                value: isChecked,
                title: Text(
                  "위 사항을 모두 확인하였으며 문제가 발생할 경우\n모든 책임을 질 것에 동의합니다.",
                  style: kTextMainStyleSmall,
                  textAlign: TextAlign.center,
                ),
                onChanged: (value) => setState(() {
                  isChecked = !isChecked;
                }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: isChecked
              ? () async {
                  await widget.onPressed();
                  if (context.mounted) Navigator.of(context).pop();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.mainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(
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
