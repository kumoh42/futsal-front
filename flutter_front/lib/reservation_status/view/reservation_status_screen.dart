import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/reservation_status/view/reservation_member_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_setting_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final horizontalScrollController = ScrollController();
    return Scrollbar(
      controller: horizontalScrollController,
      child: SingleChildScrollView(
        controller: horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Container(
            width: kLayoutWidthSize - kNavigationRailSize,
            constraints: BoxConstraints(minHeight: height),
            child: const Padding(
              padding: EdgeInsets.all(kPaddingMiddleSize),
              child: Column(
                children: [
                  SizedBox(
                    height: kContainerHeightSize,
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: ReservationSettingView()),
                        Expanded(flex: 2, child: ReservationStatusView()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kContainerHeightSize,
                    child: ReservationMemberView(),
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
          ),
        ),
      ),
    );
  }
}
