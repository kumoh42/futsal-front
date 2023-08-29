import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/model/service/pre_reservation/progress_reservation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressReservationViewModelProvider =
    ChangeNotifierProvider((ref) => ProgressReservationViewModel(ref));

class ProgressReservationViewModel extends ChangeNotifier {
  final Ref ref;
  late bool isPreReservation;
  late DateTime progressReservation;
  ProgressReservationViewModel(this.ref) {
    isPreReservation = false;
    progressReservation = DateTime.now();
  }

  void stopPreReservation() async {
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .stopPreReservation();
  }

  void restartPreReservation() async {
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .restartPreReservation();
  }

  void resetPreReservation() async {
    await ref
        .read(progressResrvationServiceProvider.notifier)
        .resetPreReservation();
  }
}
