import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_elevated_button.dart';
import 'package:flutter_front/common/component/number_container.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/pre_reservation_setting_status_view.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_view/progress_reservation_view.dart';
import 'package:flutter_front/reservation_status/viewmodel/pre_reservation_viewmodel/pre_reservation_setting_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreReservationSettingView extends ConsumerStatefulWidget {
  const PreReservationSettingView({super.key});

  @override
  ConsumerState<PreReservationSettingView> createState() =>
      _PreReservationSettingViewState();
}

class _PreReservationSettingViewState
    extends ConsumerState<PreReservationSettingView> {
  @override
  void initState() {
    super.initState();
    // UI가 빌드된 후 실행
    Future(() {
      ref
          .read(preReservationSettingViewModelProvider)
          .getPreReservationStatusList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(preReservationSettingViewModelProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CustomContainer(
            title: "우선예약 설정",
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
                          GestureDetector(
                            onTap: () {
                              viewmodel.setTimePicker(context);
                            },
                            child: NumberContainer(
                              content:
                                  viewmodel.hour.toString().padLeft(2, "0"),
                              width: 60,
                              height: 40,
                            ),
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
                          GestureDetector(
                            onTap: () {
                              viewmodel.setTimePicker(context);
                            },
                            child: NumberContainer(
                              content:
                                  viewmodel.minute.toString().padLeft(2, "0"),
                              width: 60,
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomElevatedButton(
                            content: Text(
                              "APPLY",
                              style: kTextReverseStyleMiddle.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onPressed: viewmodel.setPreReservation,
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kPaddingSmallSize),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: CustomContainer(
                  title: "우선예약 설정 현황",
                  height: 250,
                  child: PreReservationStatusList(
                    state: viewmodel.statusState,
                    list: viewmodel.preReservationStatusList,
                    onCancelClicked: (p) {
                      viewmodel.canclePreReservation(context, p);
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: ProgressReservationView(),
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kPaddingMiniSize,
                vertical: kPaddingSmallSize,
              ),
              child: Text(
                "우선예약은 매월 1일 0시에 사전예약 종료 후 자동으로 시작됩니다.",
                style: kTextMainStyleSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showTimePicker() {}
}
