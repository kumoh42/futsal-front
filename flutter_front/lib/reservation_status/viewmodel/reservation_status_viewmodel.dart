import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/dialog/calendar_select_dialog.dart';
import 'package:flutter_front/reservation_status/component/reservation_cancel_dialog.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/model/entity/block_reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/entity/reservation_entity.dart';
import 'package:flutter_front/reservation_status/model/service/pre_reservation/pre_reservation_setting_service.dart';
import 'package:flutter_front/reservation_status/model/service/reservation_status_service.dart';
import 'package:flutter_front/reservation_status/model/state/reservation_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationStatusViewModelProvider =
    ChangeNotifierProvider((ref) => ReservationStatusViewModel(ref));

class ReservationStatusViewModel extends ChangeNotifier {
  final Ref ref;

  // statusState = reservationStatusServiceProvider
  late ReservationStatusListState statusState;
  late final CustomTimeTableController customTimeTableController;
  late final CustomCancelListController cancelListController;
  late final CustomTimeTableController blockReservationController;

  get reservationStatusList => statusState is ReservationStatusListStateSuccess
      ? (statusState as ReservationStatusListStateSuccess)
          .data
          .where((element) =>
              defaultDateFormat.format(element.date) ==
              defaultDateFormat.format(customTimeTableController.selectedDay))
          .toList()
      : null;

  ReservationStatusViewModel(this.ref) {
    customTimeTableController = CustomTimeTableController(
      onDayChange: getReservationStatusList,
    );
    cancelListController = CustomCancelListController();
    blockReservationController = CustomTimeTableController(useRange: true);

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

  void blockReservation(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => CalendarSelectDialog<BlockReservationEntity>(
        onPressed: (e) async {
          await ref
              .read(preReservationSettingServiceProvider.notifier)
              .blockReservation(
                start: e.startDate,
                end: e.endDate,
              );
        },
        controller: blockReservationController,
        endTimes: const [
          "10시",
          "12시",
          "14시",
          "16시",
          "18시",
          "20시",
          "22시",
        ],
        startTimes: const [
          "08시",
          "10시",
          "12시",
          "14시",
          "16시",
          "18시",
          "20시",
        ],
        title: "예약 불가 기간 설정",
      ),
    );
  }

  void getReservationStatusList() async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(date: customTimeTableController.selectedDay);
    cancelListController.reset();
    notifyListeners();
  }

  void cancelReservationStatus(
    BuildContext context,
  ) async {
    final List<ReservationStatusEntity> cancelList = [];

    for (int entityId in cancelListController.cancelIdList) {
      for (ReservationStatusEntity entity in reservationStatusList) {
        if (entity.reservationId == entityId) {
          cancelList.add(entity);
        }
      }
    }
    if (cancelList.isEmpty) return;

    await showDialog(
      context: context,
      builder: (context) => ReservationCancelDialog(
        entities: cancelList,
        onPressed: (e) => ref
            .read(reservationStatusServiceProvider.notifier)
            .cancelReservation(entities: cancelList),
      ),
    );

    cancelListController.reset();
  }
}
