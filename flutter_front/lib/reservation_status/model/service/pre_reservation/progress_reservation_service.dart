import 'package:dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/repository/pre_resevation/progress_reservation_repository.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/progress_reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressResrvationServiceProvider =
    StateNotifierProvider<ProgressReservationService, ProgressReservationState>(
        (ref) {
  final progressReservationRepository =
      ref.watch(progressReservationRepositoryProvider);
  return ProgressReservationService(progressReservationRepository);
});

class ProgressReservationService
    extends StateNotifier<ProgressReservationState> {
  final ProgressReservationRepository repository;

  ProgressReservationService(this.repository)
      : super(ProgressReservationStateNone());

  Future stopPreReservation() async {
    try {
      await repository.setProgressReservation("close");
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future restartPreReservation() async {
    try {
      await repository.setProgressReservation("open");
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future getProgressReservation() async {
    try {
      state = ProgressReservationStateLoading();
      //  final data = await repository.getProgressReservation();
      state = ProgressReservationStateSuccess(ProgressReservationEntity(
          date:
              PreReservationStatusEntity(date: "2023-03-30", time: "10:00:00"),
          isPre: true));
    } on DioException {
      state = ProgressReservationStateError("서버로부터 진행중인 예약을 가져오지 못했습니다.");
    } catch (e) {
      state = ProgressReservationStateError("알 수 없는 에러가 발생했습니다");
    }
  }

  Future resetPreReservation() async {
    await repository.reset();
  }
}
