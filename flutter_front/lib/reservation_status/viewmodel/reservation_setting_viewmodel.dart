import 'package:flutter/cupertino.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/reservation_status/model/service/reservation_setting_service.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_setting_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationSettingViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationSettingViewModel(ref));

class ReservationSettingViewModel extends ChangeNotifier {
  final Ref ref;
  late ReservationSettingState settingState;

  ReservationSettingViewModel(this.ref) {
    settingState = ref.read(reservationSettingServiceProvider);
    ref.listen(reservationSettingServiceProvider, (previous, next) {
      if (previous != next) {
        settingState = next;
        if (settingState is ErrorState) {
          SnackBarUtil.showError((settingState as ErrorState).message);
        }
        if (settingState is SuccessState) {
          String? message = (settingState as SuccessState).message;
          if(message != null) SnackBarUtil.showSuccess(message);
        }
        notifyListeners();
      }
    });
  }

  Future startReservation() async {
    await ref
        .read(reservationSettingServiceProvider.notifier)
        .startReservation();
  }

  Future closeReservation() async {
    await ref
        .read(reservationSettingServiceProvider.notifier)
        .closeReservation();
  }
}
