import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_elevated_button.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/reservation_status/component/custom_container.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/progress_reservation_state.dart';
import 'package:flutter_front/reservation_status/viewmodel/pre_reservation_viewmodel/progress_reservation_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressReservationView extends ConsumerStatefulWidget {
  const ProgressReservationView({super.key});

  @override
  ConsumerState<ProgressReservationView> createState() =>
      _ProgressReservationViewState();
}

class _ProgressReservationViewState
    extends ConsumerState<ProgressReservationView> {
  @override
  void initState() {
    super.initState();
    // UI가 빌드된 후 실행
    Future(() {
      ref.read(progressReservationViewModelProvider).getProgressReservation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(progressReservationViewModelProvider);
    return CustomContainer(
      title: "진행 중인 예약",
      height: kSubPageContainerHeightSize,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (viewmodel.state is ProgressReservationStateLoading)
              const Center(child: CircularProgressIndicator()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (viewmodel.state is ProgressReservationStateSuccess)
                  Expanded(
                    child: Text(
                      '${(viewmodel.state as ProgressReservationStateSuccess).data.date.date} ${(viewmodel.state as ProgressReservationStateSuccess).data.date.time}',
                      style: kTextNormalStyleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (viewmodel.state is ProgressReservationStateError)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '서버에서 정보를 불러오지 못했습니다.',
                        style: kTextNormalStyleMiddle.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                if (viewmodel.state is! ProgressReservationStateLoading)
                  IconButton(
                    onPressed: viewmodel.refreshProgressReservation,
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
                      onPressed: () {
                        viewmodel.stopPreReservation(context);
                      },
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
                        onPressed: () {
                          viewmodel.restartPreReservation(context);
                        }),
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
                    onPressed: () {
                      viewmodel.resetPreReservation(context);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
