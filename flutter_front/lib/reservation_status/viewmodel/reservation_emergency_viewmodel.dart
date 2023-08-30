import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/component/reservation_cancel_all_dialog.dart';
import 'package:flutter_front/reservation_status/model/service/reservation_status_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationEmergencyViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationEmergencyViewModel(ref));

class ReservationEmergencyViewModel extends ChangeNotifier {
  final Ref ref;

  ReservationEmergencyViewModel(this.ref);

  Future cancelAllReservation(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ReservationCancelAllDialog(
        onPressed: () => ref
            .read(reservationStatusServiceProvider.notifier)
            .cancelAllReservation(),
      ),
    );
  }

  // TODO : Reservation Setting Service 연결

  Future stopAllReservationSetting(BuildContext context) async {}

  Future startAllReservationSetting(BuildContext context) async {}
}
