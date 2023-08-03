import 'package:flutter_front/reservation_status/model/repository/reservation_setting_repository.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_setting_status.dart';
import 'package:flutter_front/reservation_status/type/reservation_setting_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationSettingServiceProvider =
    StateNotifierProvider<ReservationSettingService, ReservationSettingState>(
        (ref) {
  final reservationRepository = ref.watch(reservationSettingRepositoryProvider);
  return ReservationSettingService(reservationRepository);
});

class ReservationSettingService extends StateNotifier<ReservationSettingState> {
  final ReservationSettingRepository repository;

  ReservationSettingService(this.repository)
      : super(ReservationSettingStateNone());

  Future startReservation() async {
    try {
      state = ReservationSettingStateLoading();
      await repository.setPreReservationState("start");
      state = ReservationSettingStateSuccess(ReservationSettingType.started);
    } catch (e) {
      state = ReservationSettingStateError(e.toString());
    }
  }

  Future closeReservation() async {
    try {
      state = ReservationSettingStateLoading();
      await repository.setPreReservationState("close");
      state = ReservationSettingStateSuccess(ReservationSettingType.closed);
    } catch (e) {
      state = ReservationSettingStateError(e.toString());
    }
  }
}
