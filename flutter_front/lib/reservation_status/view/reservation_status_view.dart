import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_item.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusView extends ConsumerWidget {
  const ReservationStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return CustomContainer(
          width: width,
          height: height,
          title: "예약 확인",
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            return Center(
              child: Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      height: height,
                      isBackground: true,
                      boarderRadius: 0,
                      color: CustomColor.disabledColor,
                      child: CustomTimeTable(
                        controller: viewmodel.customTimeTableController,
                        rowHeight: 41,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomContainer(
                      height: height,
                      color: CustomColor.disabledColor,
                      isBackground: true,
                      boarderRadius: 0,
                      child: viewmodel.statusState is LoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : viewmodel.statusState is SuccessState
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      viewmodel.reservationStatusList.length,
                                  itemBuilder: (context, i) =>
                                      ReservationStateItem(
                                    height: height / 7 - 1.145,
                                    entity: viewmodel.reservationStatusList[i],
                                    onCancelClicked: (entity) =>
                                        viewmodel.cancelReservationStatus(
                                            context, entity),
                                  ),
                                )
                              : Container(),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
