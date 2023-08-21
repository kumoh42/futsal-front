import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/pre_reservation_setting_status_view.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/progress_reservation_view.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreReservationSettingView extends ConsumerWidget {
  const PreReservationSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CustomContainer(
            title: "사전 예약 설정",
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomContainer(
                          width: width,
                          height: height,
                          isBackground: true,
                          boarderRadius: 0,
                          boarderColor: CustomColor.disabledColor,
                          boarderWidth: kBorderSideWidth * 10,
                          color: CustomColor.backgroundMainColor,
                          child: CustomTimeTable(
                            controller: viewmodel.customTimeTableController,
                            rowHeight: 41,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            size: kIconMainSize,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const NumberContainer(
                            content: "20",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            ":",
                            style: kTextMainStyleMiddle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const NumberContainer(
                            content: "20",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // 배경색을 검정색으로 설정
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), // 둥근 모서리 설정
                              ),
                            ),
                            onPressed: () {
                              // 버튼이 클릭되었을 때 실행될 코드
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 1,
                              ),
                              child: Text(
                                'APPLY',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const Row(
          children: [
            Expanded(
              flex: 3,
              child: PreReservationSettingStatusView(),
            ),
            Expanded(
              flex: 2,
              child: ProgressReservation(),
            ),
          ],
        ),
        const Text("정규예약은 매월 1일 0시에 사전예약 종료 후 자동으로 시작됩니다."),
      ],
    );
  }
}

class NumberContainer extends StatelessWidget {
  final String content;
  const NumberContainer({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          content,
          style: kTextMainStyleMiddle,
        ),
      ),
    );
  }
}
