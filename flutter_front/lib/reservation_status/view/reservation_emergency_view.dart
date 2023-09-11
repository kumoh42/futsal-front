import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_outlined_button.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_emergency_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationEmergencyView extends ConsumerWidget {
  ReservationEmergencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationEmergencyViewModelProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = MediaQuery.of(context).size.height;
        return CustomContainer(
          width: width / 4,
          height: height / 3,
          maxWidth: 700,
          minHeight: 275,
          title: "Emergency",
          child: Center(
            child: Column(
              // TODO : 버튼 디자인 변경
              children: [
                CustomOutlinedButton(
                  onPressed: () => viewmodel.stopAllReservationSetting(context),
                  text: "예약 긴급 중단",
                ),
                SizedBox(height: kPaddingMiddleSize),
                CustomOutlinedButton(
                  onPressed: () => viewmodel.cancelAllReservation(context),
                  text: "전체 예약 취소",
                ),
                SizedBox(height: kPaddingMiddleSize),
                CustomOutlinedButton(
                  onPressed: () => viewmodel.startAllReservationSetting(context),
                  text: "예약 제개",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
