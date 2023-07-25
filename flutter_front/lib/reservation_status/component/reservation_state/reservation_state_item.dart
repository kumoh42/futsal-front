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
      return SizedBox(
        width: constraints.maxWidth,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingMiddleSize,
                  vertical: kPaddingMiniSize,
                ),
                child: Text(
                  entity.time,
                  textAlign: TextAlign.center,
                  style: kTextMainStyleSmall,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingMiddleSize,
                    vertical: kPaddingMiniSize,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entity.member,
                          textAlign: TextAlign.center,
                          style: kTextMainStyleSmall,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onCancelClicked == null
                            ? null
                            : () => onCancelClicked!(entity),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.mainColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(kBorderRadiusSize),
                            ),
                          ),
                        ),
                        child: Text(
                          "예약 취소",
                          style: kTextMainStyleSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
