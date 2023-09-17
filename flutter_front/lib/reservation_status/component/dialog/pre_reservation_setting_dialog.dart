import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container_title_bar.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreReservationSettingDialog extends ConsumerStatefulWidget {
  final Future Function(ProgressReservationEntity) onPressed;
  late final ChangeNotifierProvider<CustomTimeTableController> provider;

  PreReservationSettingDialog({
    Key? key,
    required this.onPressed,
    required CustomTimeTableController controller,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<PreReservationSettingDialog> createState() =>
      _ReservationBlockDialogState();
}

class _ReservationBlockDialogState
    extends ConsumerState<PreReservationSettingDialog> {
  late CustomTimeTableController controller;

  final _startTimes = [
    "18시",
    "19시",
    "20시",
    "21시",
    "22시",
  ];

  final _endTimes = [
    "00시",
  ];

  String _selectedStartTime = '';
  String _selectedEndTime = '';

  String toNextMonth(String? date) {
    if (date == null) return '-';
    DateTime dateTime = regDateMonthFormat.parse(date);
    DateTime result = DateTime(dateTime.year, dateTime.month + 1, 1);
    return regDateFormatK.format(result);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedStartTime = _startTimes[0];
      _selectedEndTime = _endTimes[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: DesignedContainerTitleBar(
            title: '예약 불가 기간 설정',
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, size: kIconMiddleSize.w),
              )
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
          ),
          content: SizedBox(
            height: max(width / 2, 850) * 8 / 15,
            width: max(width / 2, 850),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTimeTable(
                    controller: controller,
                    textSize: kTextMiddleSize.sp,
                  ),
                ),
                SizedBox(width: kPaddingMiddleSize.w),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kPaddingLargeSize.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: kPaddingLargeSize.w),
                        buildDateTimeSelector(
                          title: "시작 일시",
                          content: regDateFormatK.format(
                            controller.selectedDay,
                          ),
                          selectedTime: _selectedStartTime,
                          times: _startTimes,
                          onChanged: (value) {
                            setState(() => _selectedStartTime = value!);
                          },
                        ),
                        buildDateTimeSelector(
                          title: "종료 일시",
                          content: toNextMonth(
                            regDateMonthFormat.format(controller.selectedDay),
                          ),
                          selectedTime: _selectedEndTime,
                          times: _endTimes,
                          onChanged: (value) {
                            setState(() => _selectedEndTime = value!);
                          },
                        ),
                        const Spacer(),
                        DesignedButton(
                          text: '저장',
                          icon: Icons.save,
                          onPressed: () async {
                            await widget.onPressed(ProgressReservationEntity(
                              isPre: true,
                              date: defaultDateFormat.format(
                                controller.selectedDay,
                              ),
                              time: _selectedStartTime.substring(0, 2),
                            ));
                            if (context.mounted) Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildDateTimeSelector({
  required String title,
  required String content,
  required String selectedTime,
  required List<String> times,
  required void Function(String?)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: kTextDisabledStyle.copyWith(fontSize: kTextSmallSize.sp),
      ),
      Row(
        children: [
          Text(
            content,
            style: kTextMainStyle.copyWith(fontSize: kTextMiddleSize.sp),
          ),
          SizedBox(width: kPaddingMiddleSize.w),
          DropdownButton(
            value: selectedTime,
            items: times
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: kTextMainStyle.copyWith(
                        fontSize: kTextMiddleSize.sp,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          )
        ],
      ),
    ],
  );
}
