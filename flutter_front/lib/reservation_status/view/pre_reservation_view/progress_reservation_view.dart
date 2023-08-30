import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_elevated_button.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/viewmodel/pre_reservation_viewmodel/progress_reservation_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressReservationView extends ConsumerWidget {
  const ProgressReservationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(progressReservationViewModelProvider);
    return CustomContainer(
      title: "진행 중인 예약",
      height: kSubPageContainerHeightSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  regDateTimeFormatK
                      .format(viewmodel.progressReservation)
                      .replaceFirst("일 ", "일\n"),
                  style: kTextNormalStyleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: viewmodel.getProgressReservation,
                icon: const Icon(Icons.refresh_outlined),
                splashRadius: 15,
              ),
            ],
          ),
          const SizedBox(
            height: kPaddingSmallSize,
          ),
          Row(
            children: [
              Column(
                children: [
                  CustomElevatedButton(
                    color: CustomColor.mainColor,
                    verticalPadding: 5,
                    horizontalPadding: 0,
                    content: const Row(
                      children: [
                        Icon(Icons.pause),
                        Text(
                          "예약중단",
                          style: kTextReverseStyleSmall,
                        ),
                      ],
                    ),
                    onPressed: viewmodel.stopPreReservation,
                  ),
                  const SizedBox(
                    height: kPaddingMiddleSize,
                  ),
                  CustomElevatedButton(
                    color: CustomColor.mainColor,
                    verticalPadding: 5,
                    horizontalPadding: 0,
                    content: const Row(
                      children: [
                        Icon(Icons.play_arrow),
                        Text(
                          "예약재개",
                          style: kTextReverseStyleSmall,
                        ),
                      ],
                    ),
                    onPressed: viewmodel.restartPreReservation,
                  ),
                ],
              ),
              const SizedBox(
                width: kPaddingMiddleSize,
              ),
              CustomElevatedButton(
                color: CustomColor.pointColor,
                verticalPadding: 16,
                horizontalPadding: 0,
                content: Column(
                  children: [
                    const Icon(Icons.refresh_outlined),
                    Text(
                      "예약내역\n  초기화",
                      style: kTextReverseStyleSmall.copyWith(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                onPressed: viewmodel.resetPreReservation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
