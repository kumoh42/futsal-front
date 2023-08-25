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

// 이 class에서의 state 타입은 ReservationStatusListState임.
// 여기서 ReservationStatusListStateSuccess 상태는 List를 가지고 있음
class ReservationStatusService
    extends StateNotifier<ReservationStatusListState> {
  final ReservationStatusRepository repository;

  ReservationStatusService(this.repository)
      : super(ReservationStatusListStateNone()) {
    getReservationStatusList(date: DateTime.now());
  }

  Future getReservationStatusList({DateTime? date}) async {
    if (state is SuccessState &&
        (state as ReservationStatusListStateSuccess).data.first.date.month ==
            date?.month) return;
    if (date == null && state is NoneState) return;
    try {
      final temp = state;
      state = ReservationStatusListStateLoading();
      final data = await repository.getReservationStatusList(
        defaultDateFormat.format(
          date ?? (temp as ReservationStatusListStateSuccess).data.first.date,
        ),
      );
      if (data.isEmpty) {
        state = ReservationStatusListStateNone();
      } else {
        state = ReservationStatusListStateSuccess(data);
      }
    } on DioException {
      state = ReservationStatusListStateError("서버에서 예약 정보를 가져올 수 없습니다.");
    } catch (e) {
      state = ReservationStatusListStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  // 예약 1개 삭제
  Future cancelReservation({required ReservationStatusEntity entity}) async {
    try {
      state = ReservationStatusListStateLoading();
      // 요청에 8이상 20이하의 2의 배수만 들어가야 함
      if (entity.time % 2 != 0 && 8 <= entity.time && entity.time <= 20) {
        throw Exception("취소하려고하는 예약의 시간이 잘못되었습니다.");
      }
      print("regdate : ${entity.regDate}");
      print("date: ${entity.date}");

      final cancelDate = regDateFormat.format(entity.date);

      // await repository.cancelReservation(
      //     {"date": cancelDate, "time": entity.time, "isPre": true});
      final data = await repository.getReservationStatusList(
        defaultDateFormat.format(entity.date),
      );
      state = ReservationStatusListStateSuccess(data);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
    }
  }

  // 예약 1달 삭제
  Future cancelMonthReservation(
      {required ReservationStatusEntity entity}) async {
    try {
      state = ReservationStatusListStateLoading();
      final cancelDate = regDateMonthFormat.format(entity.date);
      print(cancelDate);

      // await repository
      //     .cancelMonthReservation({"date": cancelDate, "isPre": true});
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
