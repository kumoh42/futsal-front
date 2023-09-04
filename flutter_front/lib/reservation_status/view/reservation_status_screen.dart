import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/view/default_tab_bar_view.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/pre_reservation_setting_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';

class ReservationStatusScreen extends StatelessWidget {
  ReservationStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabBarView(
      child: Padding(
        padding: const EdgeInsets.all(kPaddingMiddleSize),
        child: kIsWeb
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 예약 확인 부분
                  Expanded(
                    child: SizedBox(
                      height: kMainPageContainerHeightSize,
                      child: const ReservationStatusView(),
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  // 우선예약 부분
                  Expanded(
                    child: SizedBox(
                      height: kMainPageContainerHeightSize,
                      child: const PreReservationSettingView(),
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
                    child: const ReservationStatusView(),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  // 우선예약 부분
                  SizedBox(
                    height: kMainPageContainerHeightSize,
                    child: const PreReservationSettingView(),
                  ),
                ],
              ),
        // child: Wrap(
        //   direction: Axis.horizontal,
        //   spacing: kPaddingMiddleSize,
        //   runSpacing: kPaddingMiddleSize,
        //   children: [
        //     ReservationSettingView(),
        //     ReservationStatusView(),
        //   ],
        // ),
      ),
    );
  }
}
