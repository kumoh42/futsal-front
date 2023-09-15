import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_elevated_button.dart';
import 'package:flutter_front/common/const_styles/colors.dart';
import 'package:flutter_front/common/const_styles/sizes.dart';
import 'package:flutter_front/common/const_styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusView extends ConsumerWidget {
  ReservationStatusView({Key? key}) : super(key: key);

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
          title: "예약 현황 조회",
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              return Padding(
                padding: const EdgeInsets.all(kPaddingSmallSize),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomContainer(
                        width: width,
                        height: height,
                        isBackground: true,
                        boarderRadius: 0,
                        boarderColor: kDisabledColor,
                        boarderWidth: kBorderSideWidth * 10,
                        color: kBackgroundMainColor,
                        // container에서 실제로 보이는 부분
                        child: CustomTimeTable(
                          controller: viewmodel.customTimeTableController,
                          rowHeight: kMainPageCalendarHeightSize / 11,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomContainer(
                        height: height,
                        width: width,
                        color: kBackgroundMainColor,
                        isBackground: true,
                        boarderRadius: 0,
                        boarderColor: kDisabledColor,
                        boarderWidth: kBorderSideWidth * 10,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (viewmodel.statusState
                                  is ReservationStatusListStateSuccess)
                                Container(
                                  height: (height / 15).floorToDouble(),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: kBorderSideWidth)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPaddingMiddleSize),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: kBorderSideWidth)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: kPaddingLargeSize + 9,
                                            ),
                                            child: Text(
                                              "Time",
                                              style: kTextNormalStyleMiddle
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kPaddingMiddleSize),
                                                child: Text(
                                                  "List",
                                                  style: kTextNormalStyleMiddle
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              CustomElevatedButton(
                                                content: const Text("예약 삭제"),
                                                color: Colors.red,
                                                verticalPadding:
                                                    kPaddingMiniSize,
                                                onPressed: () {
                                                  viewmodel
                                                      .cancelReservationStatus(
                                                    context,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (viewmodel.statusState
                                  is! ReservationStatusListStateSuccess)
                                ReservationStateList(
                                  state: viewmodel.statusState,
                                  reservationStatusList:
                                      viewmodel.reservationStatusList,
                                  height: height / 2,
                                  controller: viewmodel.cancelListcontroller,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
