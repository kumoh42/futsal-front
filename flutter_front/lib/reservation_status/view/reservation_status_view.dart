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
          title: "예약 현황 조회",
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: kPaddingMiddleSize,
            runSpacing: kPaddingMiddleSize,
            children: [
              CustomTimeTable(
                controller: viewmodel.customTimeTableController,
                width: width - 500 - 40 - kPaddingMiddleSize,
              ),
              SizedBox(
                width: 500,
                height: 415,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(kBorderRadiusSize)),
                  ),
                  color: CustomColor.disabledColor,
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
