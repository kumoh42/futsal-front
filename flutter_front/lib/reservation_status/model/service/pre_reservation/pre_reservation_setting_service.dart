import 'package:dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_front/reservation_status/model/repository/pre_resevation/pre_reservation_setting_repository.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/pre_reservation_setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preReservationSettingServiceProvider = StateNotifierProvider<
    PreReservationSettingService, PreReservationSettingState>((ref) {
  final reservationRepository =
      ref.watch(preReservationSettingRepositoryProvider);
  return PreReservationSettingService(reservationRepository);
});

class PreReservationSettingService
    extends StateNotifier<PreReservationSettingState> {
  final PreReservationSettingRepository repository;

  PreReservationSettingService(this.repository)
      : super(PreReservaitonSettingStateNone());

  Future setPreReservation(
      {required PreReservationStatusEntity preReservationStatusEntity}) async {
    state = PreReservaitonSettingStateLoading();
    try {
      // await repository.setPreReservation(preReservationStatusEntity);
      final data = await getPreReservationList();
      state = PreReservationSettingListStateSuccess(data);
    } on DioException {
      state = PreReservationSettingStateError("서버와의 통신이 끊겼습니다.");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future getPreReservationList() async {
    try {
      state = PreReservationSettingListStateLoading();
      // final resp = await repository.getPreReservationList();
      // if (resp.isEmpty) {
      //   state = PreReservaitonSettingStateNone();
      // } else {
      //   state = PreReservationSettingStateSuccess(resp);
      // }

      //TODO : getPreReservationList repository 연결
      //  state = PreReservationSettingListStateSuccess(list);
    } on DioException {
      state = PreReservationSettingStateError("서버에서 예약 정보를 가져올 수 없습니다. ");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future cancelPreReservation(
      {required PreReservationStatusEntity preReservationStatusEntity}) async {
    try {
      state = PreReservaitonSettingStateLoading();

      // TODO PreReservationSettingRepository와 연결

      final data = await getPreReservationList();
    } on DioException {
      state = PreReservationSettingStateError("서버에서 예약 정보를 가져올 수 없습니다. ");
    } catch (e) {
      state = PreReservationSettingStateError("알 수 없는 에러가 발생했습니다.");
    }
  }
}