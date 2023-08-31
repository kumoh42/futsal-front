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
    repository.setProgressReservation("close");
  }

  Future restartPreReservation() async {
    repository.setProgressReservation("open");
  }

  Future<String> getProgressReservation() async {
    return "";
  }

  Future resetPreReservation() async {}
}
