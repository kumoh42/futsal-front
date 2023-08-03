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
      await repository.setPreReservationState("open");
      state = ReservationSettingStateSuccess(
        ReservationSettingType.started,
        message: "사전예약이 오픈되었습니다.",
      );
    } catch (e) {
      state = ReservationSettingStateError(e.toString());
    }
  }

  Future closeReservation() async {
    try {
      state = ReservationSettingStateLoading();
      await repository.setPreReservationState("close");
      state = ReservationSettingStateSuccess(
        ReservationSettingType.closed,
        message: "사전예약이 중단되고 기존 예약 내역이 모두 삭제되었습니다.",
      );
    } catch (e) {
      state = ReservationSettingStateError(e.toString());
    }
  }
}
