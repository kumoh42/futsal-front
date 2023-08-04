import 'package:dio/dio.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
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

  Future getReservationStatusList({DateTime? date}) async {
    if (state is SuccessState &&
        (state as ReservationStatusListStateSuccess).data.first.date.month ==
            date?.month) return;
    try {
      state = ReservationStatusListStateLoading();
      final data = await repository.getReservationStatusList(
        defaultDateFormat.format(
          date ?? (state as ReservationStatusListStateSuccess).data.first.date,
        ),
      );
      if(data.isEmpty) {
        state = ReservationStatusListStateNone();
      } else {
        state = ReservationStatusListStateSuccess(data);
      }
    } on DioException catch (e) {
      state = ReservationStatusListStateError("서버에서 예약 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = ReservationStatusListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future cancelReservation({required ReservationStatusEntity entity}) async {
    try {
      state = ReservationStatusListStateLoading();
//      await repository.cancelReservation(entity.reservationId);
      final data = await repository.getReservationStatusList(
        defaultDateFormat.format(entity.date),
      );
      state = ReservationStatusListStateSuccess(data);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }

  Future cancelAllReservation() async {
    try {
      state = ReservationStatusListStateLoading();
//      await repository.cancelAllReservation();
      state = ReservationStatusListStateSuccess([]);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }
}
