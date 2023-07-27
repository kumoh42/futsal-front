import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/model/service/reservation_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationEmergencyViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationEmergencyViewModel(ref));

class ReservationEmergencyViewModel extends ChangeNotifier {
  final Ref ref;

  ReservationEmergencyViewModel(this.ref);

  Future cancelAllReservation() async {
    ref.read(reservationStatusServiceProvider.notifier).cancelAllReservationStatus();
  }

  // TODO : Reservation Setting Service 연결

  Future stopAllReservationSetting() async {}

  Future startAllReservationSetting() async {}
}
