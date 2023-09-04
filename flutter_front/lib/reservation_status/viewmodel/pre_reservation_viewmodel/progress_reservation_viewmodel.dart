import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/custom_dialog_utils.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/reservation_status/model/service/pre_reservation/progress_reservation_service.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/progress_reservation_state.dart';
import 'package:flutter_front/reservation_status/viewmodel/pre_reservation_viewmodel/pre_reservation_setting_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressReservationViewModelProvider =
    ChangeNotifierProvider((ref) => ProgressReservationViewModel(ref));

class ProgressReservationViewModel extends ChangeNotifier {
  final Ref ref;
  late ProgressReservationState state;
  ProgressReservationViewModel(this.ref) {
    state = ref.watch(progressResrvationServiceProvider);
  }

  void getProgressReservation() async {
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .getProgressReservation();
  }

  void refreshProgressReservation() async {
    SnackBarUtil.showSuccess("새로고침");
    ref
        .read(preReservationSettingViewModelProvider.notifier)
        .getPreReservationStatusList();

    getProgressReservation();
  }

  void stopPreReservation(BuildContext context) async {
    if (state is! ProgressReservationStateSuccess) return;
    if (!(state as ProgressReservationStateSuccess).data.isPre) {
      SnackBarUtil.showError("정규예약은 중단할 수 없습니다!");
      return;
    }

    CustomDialogUtil.showCustomDialog(
        dialog: CustomDialog(
          title: const Text(
            "우선예약 중단 확인",
            style: kTextMainStyleMiddle,
          ),
          content: Text(
            '${(state as ProgressReservationStateSuccess).data.date.date} ${(state as ProgressReservationStateSuccess).data.date.time}\n예약을 중지하시겠습니까?',
            style: kTextNormalStyleLarge,
          ),
          onPressed: () async {
            await ref
                .read(progressResrvationServiceProvider.notifier)
                .stopPreReservation();
            Navigator.of(context).pop();
          },
        ),
        context: context);
  }

  void restartPreReservation(BuildContext context) async {
    if (state is! ProgressReservationStateSuccess) return;
    if (!(state as ProgressReservationStateSuccess).data.isPre) {
      SnackBarUtil.showError("정규예약은 재개 할 수 없습니다!");
      return;
    }

    CustomDialogUtil.showCustomDialog(
        dialog: CustomDialog(
          title: const Text(
            "우선예약 재개 확인",
            style: kTextMainStyleMiddle,
          ),
          content: Text(
            '${(state as ProgressReservationStateSuccess).data.date.date} ${(state as ProgressReservationStateSuccess).data.date.time}\n예약을 재개하시겠습니까?',
            style: kTextNormalStyleLarge,
          ),
          onPressed: () async {
            await ref
                .read(progressResrvationServiceProvider.notifier)
                .restartPreReservation();
            Navigator.of(context).pop();
          },
        ),
        context: context);
  }

  void resetPreReservation(BuildContext context) async {
    if (state is! ProgressReservationStateSuccess) return;
    if (!(state as ProgressReservationStateSuccess).data.isPre) {
      SnackBarUtil.showError("정규예약은 초기화 할 수 없습니다!");
      return;
    }

    CustomDialogUtil.showCustomDialog(
        dialog: CustomDialog(
          content: Text(
            '${(state as ProgressReservationStateSuccess).data.date.date} ${(state as ProgressReservationStateSuccess).data.date.time} 에 시작된\n우선예약 중 예약된 내역을 \n모두 삭제하시겠습니까?',
            style: kTextNormalStyleLarge,
          ),
          onPressed: () async {
            await ref
                .read(progressResrvationServiceProvider.notifier)
                .resetPreReservation();
            Navigator.of(context).pop();
          },
        ),
        context: context);
  }
}
