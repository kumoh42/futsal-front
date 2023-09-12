import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:flutter_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewReservationStatusView extends ConsumerWidget {
  final double height;
  const NewReservationStatusView({
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${viewmodel.customTimeTableController.focusedDay.month}월 ${viewmodel.customTimeTableController.focusedDay.day}일 (${getDayOfWeek(viewmodel.customTimeTableController.focusedDay).substring(0, 1)})',
                  style: kTextMainStyleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                ),
                iconSize: kIconMainSize,
                splashRadius: 20,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                iconSize: kIconMainSize,
                splashRadius: 20,
                onPressed: () {
                  viewmodel.cancelReservationStatus(context);
                },
              ),
            ],
          ),
          Expanded(
            child: ReservationStateList(
              state: viewmodel.statusState,
              reservationStatusList: viewmodel.reservationStatusList,
              height: height,
              controller: viewmodel.cancelListcontroller,
            ),
          ),
        ],
      ),
    );
  }
}
