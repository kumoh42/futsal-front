import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/view/default_tab_bar_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_setting_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabBarView(
      child: Padding(
        padding: EdgeInsets.all(kPaddingMiddleSize),
        child: Column(
          children: [
            SizedBox(
              height: kContainerHeightSize,
              child: ReservationStatusView(),
            ),
            SizedBox(
              height: kContainerHeightSize * 0.7,
              child: ReservationSettingView(),
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
