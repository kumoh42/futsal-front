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
          child: Column(
            children: [
              Expanded(
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
                              rowHeight: 35,
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomContainer(
                            height: height,
                            color: CustomColor.disabledColor,
                            isBackground: true,
                            boarderRadius: 0,
                            child: viewmodel.state is LoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          (viewmodel.state as SuccessState)
                                              .data
                                              .length,
                                      itemBuilder: (context, i) =>
                                          ReservationStateItem(
                                        entity:
                                            (viewmodel.state as SuccessState)
                                                .data[i],
                                        onCancelClicked: (entity) =>
                                            viewmodel.cancelReservationStatus(
                                                context, entity),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: kPaddingMiddleSize),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "현재 예약 진행상태",
                      style: kTextMainStyleMiddle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "시작됨",
                      style: kTextMainStyleMiddle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
