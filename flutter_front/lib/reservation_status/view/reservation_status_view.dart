import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusView extends ConsumerWidget {
  const ReservationStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        /* constraints -> 부모 위젯의 크기에 따라 자식 위젯의 크기가 결정 됨
          즉, ReservationStatusView를 사용하는 부모 위젯인 DefaultTabBarView의 크기에 따라
          width, height가 결정됨
        */
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return CustomContainer(
          width: width,
          height: height,
          title: "예약 확인",
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomContainer(
                        height: height,
                        isBackground: true,
                        boarderRadius: 0,
                        boarderColor: CustomColor.disabledColor,
                        boarderWidth: kBorderSideWidth * 10,
                        color: CustomColor.backgroundMainColor,
                        // container에서 실제로 보이는 부분
                        child: CustomTimeTable(
                          controller: viewmodel.customTimeTableController,
                          rowHeight: 41,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomContainer(
                        height: height,
                        color: CustomColor.backgroundMainColor,
                        isBackground: true,
                        boarderRadius: 0,
                        boarderColor: CustomColor.disabledColor,
                        boarderWidth: kBorderSideWidth * 10,
                        child: ReservationStateList(
                          state: viewmodel.statusState,
                          reservationStatusList:
                              viewmodel.reservationStatusList,
                          onCancelClicked: (entity) => viewmodel
                              .cancelReservationStatus(context, entity),
                          height: height,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
