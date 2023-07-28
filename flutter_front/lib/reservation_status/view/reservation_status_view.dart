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
        final height = MediaQuery.of(context).size.height;
        return CustomContainer(
          width: width,
          title: "예약 현황 조회",
          child: Center(
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: kPaddingMiddleSize,
              runSpacing: kPaddingMiddleSize,
              children: [
                CustomContainer(
                  width: width - 500 - 40 - kPaddingMiddleSize,
                  height: height / 2,
                  minHeight: 422,
                  isBackground: true,
                  color: CustomColor.disabledColor,
                  child: CustomTimeTable(
                    controller: viewmodel.customTimeTableController,
                    rowHeight: (height / 2 - 72) / 7,
                  ),
                ),
                CustomContainer(
                  width: 500,
                  height: height / 2,
                  minHeight: 422,
                  color: CustomColor.disabledColor,
                  isBackground: true,
                  child: viewmodel.state is LoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(kPaddingSmallSize),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                (viewmodel.state as SuccessState).data.length,
                            itemBuilder: (context, i) => ReservationStateItem(
                              entity: (viewmodel.state as SuccessState).data[i],
                              onCancelClicked:
                                  viewmodel.cancelReservationStatus,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
