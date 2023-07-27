import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_outlined_button.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_emergency_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationEmergencyView extends ConsumerWidget {
  const ReservationEmergencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationEmergencyViewModelProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth <= 700 ? 700 : constraints.maxWidth * 0.3;
        return CustomContainer(
          width: width,
          title: "Emergency",
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: kPaddingMiddleSize,
            runSpacing: kPaddingMiddleSize,
            // TODO : 버튼 디자인 변경
            children: [
              CustomOutlinedButton(
                onPressed: viewmodel.stopAllReservationSetting,
                text: "예약 긴급 중단",
              ),
              CustomOutlinedButton(
                onPressed: viewmodel.cancelAllReservation,
                text: "전체 예약 취소",
              ),
              CustomOutlinedButton(
                onPressed: viewmodel.startAllReservationSetting,
                text: "예약 제개",
              ),
            ],
          ),
        );
      },
    );
  }
}
