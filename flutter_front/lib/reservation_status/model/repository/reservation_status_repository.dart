import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'reservation_status_repository.g.dart';

final reservationStatusRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ReservationStatusRepository(dio);
});

@RestApi()
abstract class ReservationStatusRepository {
  factory ReservationStatusRepository(Dio dio, {String baseUrl}) =
  _ReservationStatusRepository;

  @GET('/reservation/{date}')
  @Headers({'accessToken' : 'true'})
  Future<List<ReservationStatusEntity>> getReservationStatusList(@Path() String date);

// Future cancelReservation(String reservationId);

// Future cancelAllReservation();
}
