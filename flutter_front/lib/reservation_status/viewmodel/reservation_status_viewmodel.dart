import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
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
  late ReservationStatusListState statusState;
  late final CustomTimeTableController customTimeTableController;

  get reservationStatusList => (statusState
          as ReservationStatusListStateSuccess)
      .data
      .where((element) =>
          defaultDateFormat.format(element.date) ==
          defaultDateFormat.format(customTimeTableController.selectedDay))
      .toList();

  ReservationStatusViewModel(this.ref) {
    customTimeTableController = CustomTimeTableController(
      onDayChange: getReservationStatusList,
    );

    statusState = ref.read(reservationStatusServiceProvider);
    ref.listen(reservationStatusServiceProvider, (previous, next) {
      if (previous != next) {
        statusState = next;
        if (statusState is ErrorState) {
          SnackBarUtil.showError((statusState as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }

  Future getReservationStatusList() async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(date: customTimeTableController.selectedDay);
    notifyListeners();
  }

  Future cancelReservationStatus(
    BuildContext context,
    ReservationStatusEntity entity,
  ) async {
    showDialog(
      context: context,
      builder: (context) => ReservationCancelDialog(
        entity: entity,
        onPressed: (e) => ref
            .read(reservationStatusServiceProvider.notifier)
            .cancelReservation(entity: e),
      ),
    );
  }
}
