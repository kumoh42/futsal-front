import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/container/designed_container_title_bar.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return AlertDialog(
      title: DesignedContainerTitleBar(
        title: '예약 불가 기간 설정',
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
      ),
      content: SizedBox(
        height: height / 2,
        width: width / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: CustomTimeTable(
                controller: controller,
                textSize: kTextMiddleSize,
              ),
            ),
            const SizedBox(width: kPaddingMiddleSize),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingLargeSize,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: kPaddingLargeSize),
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
        style: kTextDisabledStyleSmall,
      ),
      Row(
        children: [
          Text(
            content,
            style: kTextMainStyleMiddle,
          ),
          const SizedBox(width: kPaddingMiddleSize),
          DropdownButton(
            value: selectedTime,
            items: times
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: kTextMainStyleMiddle,
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
