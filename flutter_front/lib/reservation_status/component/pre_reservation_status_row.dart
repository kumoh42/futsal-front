import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';

class PreReservationStatusRow extends StatelessWidget {
  final PreReservationStatusEntity entity;
  final void Function(PreReservationStatusEntity)? onCancelClicked;

  PreReservationStatusRow({
    super.key,
    required this.entity,
    required this.onCancelClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${entity.date} ${entity.time}",
          style: kTextNormalStyleLarge,
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () => onCancelClicked!(entity),
            splashRadius: kIconMiddleSize,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            )),
      ],
    );
  }
}
