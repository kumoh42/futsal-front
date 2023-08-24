import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation_status_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'pre_reservation_setting_repository.g.dart';

final preReservationSettingRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return PreReservationSettingRepository(dio);
});

@RestApi()
abstract class PreReservationSettingRepository {
  factory PreReservationSettingRepository(Dio dio, {String baseUrl}) =
      _PreReservationSettingRepository;

  @PUT('/')
  @Headers({'accessToken': 'true'})
  Future setPreReservation(
      @Body() PreReservationStatusEntity preReservationStatusEntity);

  @PUT('/')
  @Headers({'accessToken': 'true'})
  Future<List<PreReservationStatusEntity>> getPreReservationList();
}
