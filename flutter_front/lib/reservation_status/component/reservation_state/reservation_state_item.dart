import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_donut_paint.dart';
import 'package:flutter_front/common/component/custom_listview_background_paint.dart';
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
  final bool isLast;

  ReservationStateItem({
    Key? key,
    required this.entity,
    required this.isChecked,
    required this.onPressed,
    required this.index,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor = index % 2 == 0 ? kBackgroundMainColor : kMainColor;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: kListViewTileHeightSize,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: kPaddingSmallSize,
              ),
              CustomPaint(
                size: const Size(
                    kIconMiddleSize, kIconMiddleSize), // 도넛 모양의 크기 설정
                painter: DonutPainter(isLast: isLast),
              ),
              const SizedBox(
                width: kPaddingMiniSize,
              ),
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
                      color:
                          index % 2 == 0 ? kMainColor : kBackgroundMainColor),
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
                            child: entity.major == null
                                ? entity.date
                                            .copyWith(hour: entity.time)
                                            .compareTo(DateTime.now()) ==
                                        -1
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        // 예약 불가능일때
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "예약 불가능",
                                              style: kTextNormalStyleMiddle
                                                  .copyWith(
                                                color: textColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "예약 가능",
                                              style: kTextNormalStyleMiddle
                                                  .copyWith(
                                                color: textColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        // 누군가가 예약했을 때
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
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
                                          Text(
                                            entity.major ?? '',
                                            style:
                                                kTextReverseStyleMini.copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        if (entity.major != null)
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: onPressed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  width: 1.0,
                                  color: textColor,
                                ),
                              ),
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
      },
    );
  }
}
