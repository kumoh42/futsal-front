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
  // statusState = reservationStatusServiceProvider
  late ReservationStatusListState statusState;
  late final CustomTimeTableController customTimeTableController;
  List<bool> checkedList = [];

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

    // 8시~20시 2시간 간격으로 총 7 타임이 나옴
    // 숫자 넣기 싫은데 다른 방법이 잘 안 돼요ㅠㅠ
    for (int i = 0; i < 7; i++) {
      checkedList.add(false);
    }
  }

  void getReservationStatusList() async {
    await ref
        .read(reservationStatusServiceProvider.notifier)
        .getReservationStatusList(date: customTimeTableController.selectedDay);
    checkedList = [];
    if (reservationStatusList != null) {
      for (int i = 0; i < reservationStatusList.length; i++) {
        checkedList.add(false);
      }
    }

    notifyListeners();
  }

  void clickedCheckBox(int index) {
    checkedList[index] = !checkedList[index];
    notifyListeners();
  }

  void cancelReservationStatus(
    BuildContext context,
    List<ReservationStatusEntity> entities,
  ) async {
    List<ReservationStatusEntity> cancelList = [];
    for (int i = 0; i < reservationStatusList.length; i++) {
      if (checkedList[i]) {
        cancelList.add(reservationStatusList[i]);
      }
    }
    if (cancelList.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => ReservationCancelDialog(
        entities: cancelList,
        onPressed: (e) => ref
            .read(reservationStatusServiceProvider.notifier)
            .cancelReservation(entities: cancelList),
      ),
    );
  }
}
