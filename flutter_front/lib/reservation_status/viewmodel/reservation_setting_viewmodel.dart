import 'package:flutter/cupertino.dart';
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
        notifyListeners();
      }
    });
  }

  Future startReservation() async {
    await ref.read(reservationSettingServiceProvider.notifier).startReservation();
  }

  Future closeReservation() async {
    await ref.read(reservationSettingServiceProvider.notifier).closeReservation();
  }
}
