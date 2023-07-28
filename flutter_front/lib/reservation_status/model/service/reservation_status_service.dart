import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/repository/reservation_status_repository.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationStatusServiceProvider =
    StateNotifierProvider<ReservationStatusService, ReservationStatusListState>(
        (ref) {
  final reservationRepository = ref.watch(reservationStatusRepositoryProvider);
  return ReservationStatusService(reservationRepository);
});

class ReservationStatusService
    extends StateNotifier<ReservationStatusListState> {
  final ReservationStatusRepository repository;

  ReservationStatusService(this.repository)
      : super(ReservationStatusListStateLoading()) {
    getReservationStatusList(date: DateTime.now());
  }

  Future getReservationStatusList({required DateTime date}) async {
    try {
      state = ReservationStatusListStateLoading();
      final data = await repository.getReservationStatusList(date);
      state = ReservationStatusListStateSuccess(data);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }

  Future cancelReservation({required ReservationStatusEntity entity}) async {
    try {
      state = ReservationStatusListStateLoading();
      await repository.cancelReservation(entity.reservationId);
      final data = await repository.getReservationStatusList(entity.date);
      state = ReservationStatusListStateSuccess(data);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }

  Future cancelAllReservation() async {
    try {
      state = ReservationStatusListStateLoading();
      await repository.cancelAllReservation();
      state = ReservationStatusListStateSuccess([]);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }
}
