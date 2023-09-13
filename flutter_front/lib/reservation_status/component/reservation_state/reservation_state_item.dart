import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
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
    final textStyle = kTextMainStyleMiddle.copyWith(
        color: index % 2 == 0
            ? CustomColor.backgroundMainColor
            : CustomColor.textMainColor);
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: kPaddingMiddleSize,
              ),
              child: Text(
                DataUtils.intToTimeRange(entity.time, 2),
                textAlign: TextAlign.center,
                style: kTextMainStyleMiddle,
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: MyPainter(
                    color: index % 2 == 0
                        ? CustomColor.mainColor
                        : CustomColor.backgroundMainColor),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: kPaddingMiddleSize,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: kPaddingXLargeSize,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kPaddingLargeSize * 4 / 3,
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
                                            style: textStyle,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "예약 가능",
                                            style: textStyle,
                                          ),
                                        ],
                                      )
                                : Row(
                                    // 누군가가 예약했을 때

                                    children: [
                                      Text(
                                        "${entity.circle ?? "개인"} (${entity.major})",
                                        style: textStyle,
                                      ),
                                    ],
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
                        SizedBox(
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
    this.color = CustomColor.mainColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height / 2); // 시작점 설정
    path.lineTo(size.width / 10 * 1, size.height / 10 * 6.5);
    path.lineTo(size.width / 10 * 1, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 10 * 1, 0);
    path.lineTo(size.width / 10 * 1, size.height / 10 * 3.5);

    path.lineTo(0, size.height / 2);

    path.close(); // 경로 닫기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
