import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationStatusRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ReservationStatusRepository(dio);
});

class ReservationStatusRepository {
  final Dio dio;

  ReservationStatusRepository(this.dio);

  Future<List<ReservationStatusEntity>> getReservationStatusList(
      DateTime date) async {
    return [
      ReservationStatusEntity(
        date: date,
        time: '08:00 ~ 10:00',
        reservationId: '1',
        member: "개인 (토목공학과)",
      ),
      ReservationStatusEntity(
        date: date,
        time: '10:00 ~ 12:00',
        reservationId: '2',
        member: "개인 (토목공학과)",
      ),
      ReservationStatusEntity(
        date: date,
        time: '12:00 ~ 14:00',
        reservationId: '3',
        member: "개인 (토목공학과)",
      ),
    ];
  }

  Future cancelReservationStatus(String reservationId) async {}

  Future cancelAllReservationStatus() async {}
}
