import 'package:flutter/material.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/reservation_cancel_dialog.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/service/reservation_status_service.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationStatusViewModelProvider =
ChangeNotifierProvider((ref) => ReservationStatusViewModel(ref));

class ReservationStatusViewModel extends ChangeNotifier {
  final Ref ref;
  late ReservationStatusListState state;
  late final CustomTimeTableController customTimeTableController;

  ReservationStatusViewModel(this.ref) {
    customTimeTableController = CustomTimeTableController(
      onDayChange: getReservationStatusList,
    );
    state = ref.read(reservationStatusServiceProvider);
    ref.listen(reservationStatusServiceProvider, (previous, next) {
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }

  Future getReservationStatusList() async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(date: customTimeTableController.selectedDay);
  }

  Future cancelReservationStatus(BuildContext context,
      ReservationStatusEntity entity,) async {
    showDialog(
      context: context,
      builder: (context) => ReservationCancelDialog(
        entity: entity,
        onPressed: (e) => ref.read(reservationStatusServiceProvider.notifier).cancelReservation(entity: e),
      ),
    );
  }
}
