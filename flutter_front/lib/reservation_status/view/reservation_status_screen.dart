import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/view/default_tab_bar_view.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/view/new_reservation_status_view.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/pre_reservation_setting_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationStatusScreen extends ConsumerWidget {
  ReservationStatusScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);

    return DefaultTabBarView(
      child: Padding(
        padding: EdgeInsets.all(kPaddingMiddleSize),
        child: kIsWeb
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.all(
                        kPaddingMiddleSize,
                      ),
                      child: Container(
                        height: kMainPageContainerHeightSize,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: CustomTimeTable(
                          controller: viewmodel.customTimeTableController,
                          rowHeight: kMainPageContainerHeightSize / 9,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(kPaddingMiddleSize),
                      child: NewReservationStatusView(
                          height: kMainPageContainerHeightSize),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 예약 확인 부분
                  SizedBox(
                    height: kMainPageContainerHeightSize,
                    child: ReservationStatusView(),
                  ),
                  SizedBox(width: kPaddingMiddleSize),
                  // 우선예약 부분
                  SizedBox(
                    height: kMainPageContainerHeightSize,
                    child: PreReservationSettingView(),
                  ),
                ],
              ),
      ),
    );
  }
}
