import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/const_styles/colors.dart';
import 'package:flutter_front/common/const_styles/sizes.dart';
import 'package:flutter_front/common/const_styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/reservation_status/component/titled_text.dart';
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
    Future(() => ref
        .read(preReservationSettingViewModelProvider)
        .getPreReservationStatusList());
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(preReservationSettingViewModelProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: DesignedContainer(
            title: "진행 중인 예약",
            child: Column(
              children: [
                const TitledText(
                  title: '정식 예약',
                  text: '2023년 09월 01일 00:00 ~ 2023년 09월 30일 23:59',
                ),
                const SizedBox(height: kPaddingMiddleSize),
                const TitledText(
                  title: '사전 예약',
                  text: '2023년 09월 01일 00:00 ~ 2023년 09월 30일 23:59',
                ),
                const SizedBox(height: kPaddingMiddleSize),
                Row(
                  children: [
                    DesignedButton(
                      icon: Icons.pause,
                      text: "예약 중단",
                      onPressed: () {},
                    ),
                    const SizedBox(width: kPaddingMiddleSize),
                    DesignedButton(
                      icon: Icons.play_arrow,
                      text: "예약 재개",
                      onPressed: () {},
                    ),
                    const SizedBox(width: kPaddingMiddleSize),
                    DesignedButton(
                      icon: Icons.refresh,
                      text: "예약 내역 초기화",
                      color: kPointColor,
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: kLayoutGutterSize),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignedContainer(
                title: "사전 예약 설정 현황",
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: kIconMiddleSize),
                  ),
                ],
                child: const Column(
                  children: [
                    TitledText(
                      title: '정식 예약',
                      text: '2023년 09월 28일 20:00',
                    ),
                    SizedBox(height: kPaddingMiddleSize),
                    TitledText(
                      title: '사전 예약',
                      text: '2023년 09월 30일 23:59',
                    ),
                  ],
                ),
              ),
              const Text(" ·  사전 예약은 하나만 설정 가능 합니다.", style: kTextMainStyleMiddle,),
              const Text(" ·  정식 예약은 매월 1월 00시에 자동으로 시작됩니다.", style: kTextMainStyleMiddle,),
            ],
          ),
        ),
      ],
    );
  }
}
