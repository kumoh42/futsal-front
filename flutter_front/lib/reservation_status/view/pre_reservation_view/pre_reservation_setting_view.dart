import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/component/custom_outlined_button.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_setting_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_builder/timer_builder.dart';

class ReservationSettingView extends ConsumerWidget {
  ReservationSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationSettingViewModelProvider);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return TimerBuilder.periodic(
        const Duration(seconds: 1),
        builder: (context) => CustomContainer(
          width: width,
          height: height,
          title: "${DateTime.now().month % 12 + 1}월 우선예약 오픈 설정",
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kBorderRadiusSize * 3)),
                        side: BorderSide(width: 3, color: Colors.black)),
                    child: Padding(
                      padding: EdgeInsets.all(kPaddingLargeSize),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("현재 시각", style: kTextMainStyleLarge),
                          Text(
                            settingDateFormat.format(DateTime.now()),
                            textAlign: TextAlign.center,
                            style: kTextMainStyleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: kPaddingMiddleSize),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: kPaddingMiddleSize * 2),
                      viewmodel.settingState is LoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                        children: [
                          Expanded(
                            child: CustomOutlinedButton(
                              height: 75,
                              borderRadius: 0,
                              elevation: 5,
                              onPressed: viewmodel.startReservation,
                              text: "예약 시작",
                            ),
                          ),
                          SizedBox(width: kPaddingMiddleSize),
                          Expanded(
                            child: CustomOutlinedButton(
                              height: 75,
                              borderRadius: 0,
                              elevation: 5,
                              color: CustomColor.pointColor,
                              onPressed: viewmodel.closeReservation,
                              text: "예약 중단 및 기존 예약 내역 삭제",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kPaddingMiddleSize),
                      const Text("정식 예약은 매월 1일 0시에 시작됩니다."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
