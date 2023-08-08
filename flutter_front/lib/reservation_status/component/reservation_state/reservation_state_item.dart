import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/data_utils.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationStateItem extends StatelessWidget {
  final ReservationStatusEntity entity;
  final double? height;
  final void Function(ReservationStatusEntity)? onCancelClicked;

  const ReservationStateItem(
      {Key? key, this.height, required this.entity, this.onCancelClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: height,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: kBorderSideWidth)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(width: kBorderSideWidth)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPaddingSmallSize + 2,
                  horizontal: kPaddingMiddleSize,
                ),
                child: Text(
                  DataUtils.intToTimeRange(entity.time, 2),
                  textAlign: TextAlign.center,
                  style: kTextNormalStyleMiddle,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPaddingSmallSize + 2,
                  horizontal: kPaddingMiddleSize,
                ),
                child: entity.major == null
                    ? entity.date.copyWith(hour:entity.time).compareTo(DateTime.now()) == -1
                        ? Row(
                            children: [
                              Image.asset(
                                "assets/image/delete.png",
                                width: kTextMiddleSize,
                                height: kTextMiddleSize,
                              ),
                              const SizedBox(width: kPaddingSmallSize),
                              const Text(
                                "예약 불가능",
                                style: kTextNormalStyleMiddle,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Image.asset(
                                "assets/image/check.png",
                                width: kTextMiddleSize,
                                height: kTextMiddleSize,
                              ),
                              const SizedBox(width: kPaddingSmallSize),
                              const Text(
                                "예약 가능",
                                style: kTextNormalStyleMiddle,
                              ),
                            ],
                          )
                    : Text(
                        "${entity.circle ?? "개인"} (${entity.major})",
                        style: kTextNormalStyleMiddle,
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
