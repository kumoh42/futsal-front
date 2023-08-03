import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';

class ReservationStateItem extends StatelessWidget {
  final ReservationStatusEntity entity;
  final Function(ReservationStatusEntity)? onCancelClicked;

  const ReservationStateItem(
      {Key? key, required this.entity, this.onCancelClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(width: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPaddingSmallSize,
                  horizontal: kPaddingMiddleSize,
                ),
                child: Text(
                  "${entity.time}:00 ~ ${entity.time + 2}:00",
                  textAlign: TextAlign.center,
                  style: kTextMainStyleMiddle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingSmallSize,
                horizontal: kPaddingMiddleSize,
              ),
              child: entity.major == null
                  ? entity.isAble == "N"
                      ? Row(
                          children: [
                            Image.asset(
                              "assets/image/delete.png",
                              width: kTextMiddleSize,
                              height: kTextMiddleSize,
                            ),
                            const SizedBox(width: kPaddingSmallSize),
                            const Text("예약 불가능", style: kTextMainStyleMiddle),
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
                            const Text("예약 가능", style: kTextMainStyleMiddle),
                          ],
                        )
                  : Text(
                      "${entity.circle ?? "개인"} (${entity.major})",
                      style: kTextMainStyleMiddle,
                    ),
            ),
          ],
        ),
      );
    });
  }
}
