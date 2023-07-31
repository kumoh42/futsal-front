import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationSettingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ReservationSettingRepository(dio);
});

class ReservationSettingRepository {
  final Dio dio;

  ReservationSettingRepository(this.dio);

  Future startReservation() async {}

  Future closeReservation() async {}
}
