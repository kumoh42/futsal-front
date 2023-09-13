import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_front/reservation_status/component/custom_table_calendar.dart';
import 'package:flutter_front/reservation_status/model/entity/block_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationBlockDialog extends ConsumerStatefulWidget {
  final Future Function(BlockReservationEntity) onPressed;
  late final ChangeNotifierProvider<CustomTimeTableController> provider;

  ReservationBlockDialog({
    Key? key,
    required this.onPressed,
    required CustomTimeTableController controller,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<ReservationBlockDialog> createState() =>
      _ReservationBlockDialogState();
}

class _ReservationBlockDialogState
    extends ConsumerState<ReservationBlockDialog> {
  late CustomTimeTableController controller;
  final _endTimes = [
    "10시",
    "12시",
    "14시",
    "16시",
    "18시",
    "20시",
  ];
  final _startTimes = [
    "08시",
    "10시",
    "12시",
    "14시",
    "16시",
    "18시",
  ];

  String _selectedStartTime = '';
  String _selectedEndTime = '';

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
      title: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: kPaddingMiddleSize,
                ),
                child: const Text('예약 불가 기간 설정'),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      titleTextStyle: kTextMainStyleLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kBorderRadiusSize),
        ),
      ),
      content: SizedBox(
        height: height * 3 / 7,
        width: width / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: CustomTimeTable(
                controller: controller,
                rowHeight: height / 20,
              ),
            ),
            SizedBox(
              width: kPaddingMiddleSize,
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPaddingMiddleSize,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kPaddingLargeSize,
                      ),
                      buildDateTimeSelector(
                        title: "시작 일시",
                        content: regDateTimeFormatK
                            .format(
                                controller.startDay ?? controller.selectedDay)
                            .toString()
                            .substring(0, 13),
                        selectedTime: _selectedStartTime,
                        times: _startTimes,
                        onChanged: (value) {
                          setState(
                            () {
                              _selectedStartTime = value!;
                            },
                          );
                        },
                      ),
                      buildDateTimeSelector(
                        title: "종료 일시",
                        content: regDateTimeFormatK
                            .format(controller.endDay ?? controller.selectedDay)
                            .toString()
                            .substring(0, 13),
                        selectedTime: _selectedEndTime,
                        times: _endTimes,
                        onChanged: (value) {
                          setState(
                            () {
                              _selectedEndTime = value!;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await widget.onPressed(
              BlockReservationEntity(
                startDate:
                    '${controller.startDay.toString().split(" ")[0]}T${_selectedStartTime.substring(0, 2)}',
                endDate:
                    '${controller.endDay.toString().split(" ")[0]}T${_selectedEndTime.substring(0, 2)}',
              ),
            );
            if (context.mounted) Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.mainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: kPaddingLargeSize,
              vertical: kPaddingMiddleSize,
            ),
          ),
          child: SizedBox(
            width: width / 20,
            child: Row(
              children: [
                const Icon(Icons.save),
                SizedBox(
                  width: kPaddingSmallSize,
                ),
                Text(
                  '저장',
                  style: kTextMainStyleMiddle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextSubStyleSmall.copyWith(
            color: const Color(0XFF777777),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              content,
              style: kTextMainStyleMiddle,
            ),
            DropdownButton(
              value: selectedTime,
              items: times
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: kTextMainStyleMiddle,
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
            )
          ],
        ),
      ],
    ),
  );
}
