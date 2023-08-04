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

  Future getReservationStatusList({required DateTime date}) async {
    if (state is SuccessState &&
        (state as ReservationStatusListStateSuccess).data.first.date.month ==
            date.month) return;
    try {
      state = ReservationStatusListStateLoading();
      // final data = await repository.getReservationStatusList(
      //   defaultDateFormat.format(date),
      // );
      final data = [
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 8,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과컴퓨터공학과컴퓨터공학과컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 10,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 12,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 14,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 16,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 18,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
        ReservationStatusEntity(
          reservationId: 1,
          placeId: null,
          date: date,
          time: 20,
          isAble: "N",
          isHoliday: "N",
          regDate: date,
          circle: null,
          major: "컴퓨터공학과",
        ),
      ];
      state = ReservationStatusListStateSuccess(data);
    } catch (e) {
      state = ReservationStatusListStateError(e.toString());
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
