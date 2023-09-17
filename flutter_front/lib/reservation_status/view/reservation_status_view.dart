import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/stack_container.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationStatusView extends ConsumerWidget {
  const ReservationStatusView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: StackContainer(
              child: CustomTimeTable(
                  controller: viewmodel.customTimeTableController),
            )),
        const SizedBox(width: kLayoutGutterSize),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: kPaddingMiddleSize.w * 3),
                  Expanded(
                    child: Text(
                      '${viewmodel.customTimeTableController.focusedDay.month}월 ${viewmodel.customTimeTableController.focusedDay.day}일 (${getDayOfWeek(viewmodel.customTimeTableController.focusedDay).substring(0, 1)})',
                      style: kTextMainStyle.copyWith(fontSize: kTextLargeSize.sp),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: kIconMiddleSize.w,
                    splashRadius: kIconMiddleSize.w,
                    onPressed: () {
                      viewmodel.blockReservation(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: kIconMiddleSize.w,
                    splashRadius: kIconMiddleSize.w,
                    onPressed: () {
                      viewmodel.cancelReservationStatus(context);
                    },
                  ),
                  const SizedBox(width: 5.0),
                ],
              ),
              SizedBox(height: kPaddingLargeSize.w),
              Expanded(
                child: ReservationStateList(
                  state: viewmodel.statusState,
                  reservationStatusList: viewmodel.reservationStatusList,
                  controller: viewmodel.cancelListController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
