import 'package:flutter/material.dart';
import 'package:flutter_front/common/const_styles/colors.dart';
import 'package:flutter_front/common/const_styles/sizes.dart';
import 'package:flutter_front/common/const_styles/text_styles.dart';
import 'package:flutter_front/common/utils/data_utils.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationStateItem extends StatelessWidget {
  final ReservationStatusEntity entity;
  final void Function(bool?) onPressed;
  final bool isChecked;
  final int index;

  ReservationStateItem({
    Key? key,
    required this.entity,
    required this.isChecked,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        index % 2 == 0 ? kBackgroundMainColor : kTextMainColor;
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: kPaddingMiddleSize,
              ),
              child: Text(
                DataUtils.intToTimeRange(entity.time, 2),
                textAlign: TextAlign.center,
                style: kTextMainStyleSmall,
              ),
            ),
            const SizedBox(
              width: kPaddingMiniSize,
            ),
            Expanded(
              child: CustomPaint(
                painter: MyPainter(
                    color: index % 2 == 0 ? kMainColor : kBackgroundMainColor),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: kPaddingMiddleSize,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: kPaddingLargeSize,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kPaddingLargeSize * 5 / 2,
                            ),
                            child: entity.major == null
                                ? entity.date
                                            .copyWith(hour: entity.time)
                                            .compareTo(DateTime.now()) ==
                                        -1
                                    ? Row(
                                        // 예약 불가능일때
                                        children: [
                                          Text(
                                            "예약 불가능",
                                            style:
                                                kTextNormalStyleMiddle.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "예약 가능",
                                            style:
                                                kTextNormalStyleMiddle.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      )
                                : IntrinsicHeight(
                                    child: Row(
                                      // 누군가가 예약했을 때

                                      children: [
                                        Text(
                                          entity.circle ?? "개인",
                                          style: kTextMainStyleLarge.copyWith(
                                            color: textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: kPaddingMiniSize,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            entity.major ?? '',
                                            style:
                                                kTextReverseStyleMini.copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      if (entity.major != null)
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: onPressed,
                          ),
                        ),
                      if (entity.major == null)
                        const SizedBox(
                          width: kPaddingMiddleSize,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MyPainter extends CustomPainter {
  final Color? color;
  MyPainter({
    this.color = kMainColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 30, size.height / 2); // 시작점 설정
    path.lineTo(size.width / 10 * 1, size.height / 10 * 6.5);
    path.lineTo(size.width / 10 * 1, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 10 * 1, 0);
    path.lineTo(size.width / 10 * 1, size.height / 10 * 3.5);
    path.lineTo(size.width / 30, size.height / 2);

    path.close(); // 경로 닫기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
