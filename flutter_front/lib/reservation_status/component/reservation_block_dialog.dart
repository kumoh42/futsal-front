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

// TODO  Date Range Picker로 바꿔보기
class _ReservationBlockDialogState
    extends ConsumerState<ReservationBlockDialog> {
  late CustomTimeTableController controller;
  final _endTimes = [
    "10",
    "12",
    "14",
    "16",
    "18",
    "20",
  ];
  final _startTimes = [
    "08",
    "10",
    "12",
    "14",
    "16",
    "18",
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
        height: height * 2 / 5,
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "시작 일시",
                              style: kTextSubStyleSmall.copyWith(
                                color: const Color(
                                  0XFF777777,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  regDateTimeFormatK
                                      .format(controller.selectedDay)
                                      .toString()
                                      .substring(0, 13),
                                  style: kTextMainStyleMiddle,
                                ),
                                DropdownButton(
                                  value: _selectedStartTime,
                                  items: _startTimes
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: kTextMainStyleMiddle,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _selectedStartTime = value!;
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "종료 일시",
                              style: kTextSubStyleSmall.copyWith(
                                color: const Color(
                                  0XFF777777,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  regDateTimeFormatK
                                      .format(controller.selectedDay)
                                      .toString()
                                      .substring(0, 13),
                                  style: kTextMainStyleMiddle,
                                ),
                                DropdownButton(
                                  value: _selectedEndTime,
                                  items: _endTimes
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: kTextMainStyleMiddle,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _selectedEndTime = value!;
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
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
            // await onPressed(entity);
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
