import 'package:flutter/material.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/custom_dialog_utils.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/common/utils/snack_bar_util.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_front/reservation_status/model/service/pre_reservation/pre_reservation_setting_service.dart';
import 'package:flutter_front/reservation_status/model/state/pre_reservation/pre_reservation_setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preReservationSettingViewModelProvider =
    ChangeNotifierProvider((ref) => PreReservationSettingViewModel(ref));

class PreReservationSettingViewModel extends ChangeNotifier {
  final Ref ref;
  late final CustomTimeTableController customTimeTableController;
  late int hour;
  late int minute;
  late PreReservationSettingState statusState;

  PreReservationSettingViewModel(this.ref) {
    customTimeTableController = CustomTimeTableController();
    hour = DateTime.now().hour;
    minute = DateTime.now().minute;
    statusState = ref.watch(preReservationSettingServiceProvider);

    ref.listen(preReservationSettingServiceProvider, (previous, next) {
      if (previous != next) {
        statusState = next;
        if (statusState is ErrorState) {
          SnackBarUtil.showError((statusState as ErrorState).message);
        }
        notifyListeners();
      }
    });
  }
  get preReservationStatusList =>
      statusState is PreReservationSettingListStateSuccess
          ? (statusState as PreReservationSettingListStateSuccess).data
          : null;

  void getPreReservationStatusList() async {
    await ref
        .read(preReservationSettingServiceProvider.notifier)
        .getPreReservationList();
  }

  void setTimePicker(BuildContext context) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: hour,
        minute: minute,
      ),
    );
    selectedTime.then(
      (timeOfDay) {
        if (timeOfDay != null) {
          hour = timeOfDay.hour;
          minute = timeOfDay.minute;

          notifyListeners();
        }
      },
    );
  }

  void setPreReservation(BuildContext context) async {
    final dates =
        defaultDateFormat.format(customTimeTableController.focusedDay);
    final times =
        '${hour.toString().padLeft(2, "0")}-${minute.toString().padLeft(2, "0")}';

    final entity = PreReservationStatusEntity(dates: dates, times: times);

    CustomDialogUtil.showCustomDialog(
      dialog: CustomDialog(
        title: const Text(
          '우선예약 설정 확인',
          style: kTextMainStyleMiddle,
        ),
        content: Text(
          ' $dates ${times.replaceFirst("-", "시 ")}분',
          style: kTextNormalStyleLarge,
        ),
        accept: "확인",
        cancel: "취소",
        onPressed: () async {
          await ref
              .read(preReservationSettingServiceProvider.notifier)
              .setPreReservation(preReservationStatusEntity: entity);
          Navigator.of(context).pop();
        },
      ),
      context: context,
    );
  }

  void canclePreReservation(
      BuildContext context, PreReservationStatusEntity entity) async {
    await ref
        .read(preReservationSettingServiceProvider.notifier)
        .cancelPreReservation(preReservationStatusEntity: entity);
  }
}
