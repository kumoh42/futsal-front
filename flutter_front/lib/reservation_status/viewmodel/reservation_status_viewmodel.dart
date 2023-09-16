import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/reservation_block_dialog.dart';
import 'package:flutter_front/reservation_status/component/reservation_cancel_dialog.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
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
  late final CustomCancelListController cancelListcontroller;
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
    cancelListcontroller = CustomCancelListController();
    blockReservationController = CustomTimeTableController(useRange: true);

    statusState = ref.read(reservationStatusServiceProvider);
    /* 
    프로바이더의 상태 변경을 감지하고, 변경 사항이 있을 때마다 특정 동작을 수행하는 부분
    두 번째 매개변수로는 변경 이전의 상태(previous)와 변경 후의 상태(next)를 받음
    */
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
  void blockReservation(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => ReservationBlockDialog(
        controller: blockReservationController,
        onPressed: (e) => ref
            .read(preReservationSettingServiceProvider.notifier)
            .blockReservation(
              start: e.startDate,
              end: e.endDate,
            ),
      ),
    );
  }

  void getReservationStatusList() async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(date: customTimeTableController.selectedDay);
    cancelListcontroller.reset();
    notifyListeners();
  }

  void cancelReservationStatus(
    BuildContext context,
  ) async {
    final List<ReservationStatusEntity> cancelList = [];

    for (int entityId in cancelListcontroller.cancelIdList) {
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

    cancelListcontroller.reset();
  }
}
