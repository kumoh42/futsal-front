import 'package:dio/dio.dart';
import 'package:flutter_front/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'progress_reservation_repository.g.dart';

final progressReservationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ProgressReservationRepository(dio);
});

@RestApi()
abstract class ProgressReservationRepository {
  factory ProgressReservationRepository(Dio dio, {String baseUrl}) =
      _ProgressReservationRepository;
}
