import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/component/custom_outlined_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_builder/timer_builder.dart';

class ReservationSettingView extends ConsumerWidget {
  const ReservationSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return CustomContainer(
        width: width,
        height: height,
        title: "예약 설정",
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize * 3)),
                    side: BorderSide(width: 3, color: Colors.black)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kPaddingLargeSize),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("현재 날짜 및 시간", style: kTextMainStyleLarge),
                        const SizedBox(height: kPaddingLargeSize),
                        TimerBuilder.periodic(
                          const Duration(seconds: 1),
                          builder: (context) => Text(
                            settingDateTime.format(DateTime.now()),
                            textAlign: TextAlign.center,
                            style: kTextMainStyleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: kPaddingMiddleSize),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      height: 75,
                      borderRadius: 0,
                      elevation: 5,
                      onPressed: () {},
                      text: "예약 시작",
                    ),
                  ),
                  const SizedBox(width: kPaddingMiddleSize),
                  Expanded(
                    child: CustomOutlinedButton(
                      height: 75,
                      borderRadius: 0,
                      elevation: 5,
                      color: CustomColor.pointColor,
                      onPressed: () {},
                      text: "예약 종료",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
