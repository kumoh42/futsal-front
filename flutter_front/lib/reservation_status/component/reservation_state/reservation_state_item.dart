import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/data_utils.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStateItem extends ConsumerStatefulWidget {
  final ReservationStatusEntity entity;
  final double? height;
  late final ChangeNotifierProvider<CustomCancelListController> provider;

  ReservationStateItem({
    Key? key,
    this.height,
    required this.entity,
    required CustomCancelListController controller,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<ReservationStateItem> createState() =>
      _ReservationStateItemState();
}

class _ReservationStateItemState extends ConsumerState<ReservationStateItem> {
  late CustomCancelListController controller;
  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: widget.height,
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
                  DataUtils.intToTimeRange(widget.entity.time, 2),
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
                child: widget.entity.major == null
                    ? widget.entity.date
                                .copyWith(hour: widget.entity.time)
                                .compareTo(DateTime.now()) ==
                            -1
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.entity.circle ?? "개인"} (${widget.entity.major})",
                            style: kTextNormalStyleMiddle,
                          ),
                          Transform.scale(
                            scale: 1.3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: kPaddingMiddleSize),
                              child: Checkbox(
                                value: controller
                                    .isChecked(widget.entity.reservationId),
                                onChanged: (value) {
                                  controller.clickedCheckBox(
                                      widget.entity.reservationId);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
