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
                  entity.time,
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
              child: Text(
                "${entity.circle} (${entity.major})",
                style: kTextMainStyleMiddle,
              ),
            ),
          ],
        ),
      );
    });
  }
}
