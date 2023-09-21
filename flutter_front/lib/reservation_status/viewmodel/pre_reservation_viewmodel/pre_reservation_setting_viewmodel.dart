import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/custom_dialog_utils.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/dialog/calendar_select_dialog.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
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
  }

  PreReservationStatusEntity? get preReservationStatus =>
      statusState is PreReservationSettingStateSuccess
          ? (statusState as PreReservationSettingStateSuccess).data
          : null;

  void getPreReservationStatus() async {
    await ref
        .read(preReservationSettingServiceProvider.notifier)
        .getPreReservation();
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
    await showDialog(
      context: context,
      builder: (context) => CalendarSelectDialog(
        onPressed: (controller, startTime, endTime) async {
          final entity = ProgressReservationEntity(
            isPre: true,
            date: defaultDateFormat.format(
              controller.selectedDay,
            ),
            time: startTime.substring(0, 2),
          );
          await ref
              .read(preReservationSettingServiceProvider.notifier)
              .setPreReservation(progressReservationEntity: entity);

          if (context.mounted) Navigator.of(context).pop();
        },
        controller: customTimeTableController,
        startTimes: const [
          "18시",
          "19시",
          "20시",
          "21시",
          "22시",
        ],
        endTimes: const [
          "00시",
        ],
        title: "사전 예약 기간 설정",
      ),
    );
  }

  void cancelPreReservation(
      BuildContext context, PreReservationStatusEntity entity) async {
    CustomDialogUtil.showCustomDialog(
      dialog: CustomDialog(
        title: Text(
          '우선예약 설정 취소',
          style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize),
        ),
        content: Text(
          ' ${entity.date} ${entity.time}',
          style: kTextNormalStyle.copyWith(fontSize: kTextLargeSize),
        ),
        accept: "확인",
        cancel: "취소",
        onPressed: () async {
          await ref
              .read(preReservationSettingServiceProvider.notifier)
              .cancelPreReservation(preReservationStatusEntity: entity);
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
      context: context,
    );
  }
}
