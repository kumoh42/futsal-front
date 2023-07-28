import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_member_entity.dart';
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
        member: ReservationMemberEntity(
          id: 'id',
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      ),
      ReservationStatusEntity(
        date: date,
        time: '08:00 ~ 10:00',
        reservationId: '1',
        member: ReservationMemberEntity(
          id: 'id',
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      ),
      ReservationStatusEntity(
        date: date,
        time: '08:00 ~ 10:00',
        reservationId: '1',
        member: ReservationMemberEntity(
          id: 'id',
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      ),
    ];
  }

  Future cancelReservation(String reservationId) async {}

  Future cancelAllReservation() async {}
}
