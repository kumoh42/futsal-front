import 'package:flutter/material.dart';
import 'package:flutter_front/common/const_styles/colors.dart';
import 'package:flutter_front/common/const_styles/sizes.dart';
import 'package:flutter_front/common/const_styles/text_styles.dart';
import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTimeTable extends ConsumerStatefulWidget {
  late final ChangeNotifierProvider<CustomTimeTableController> provider;
  final double rowHeight;
  final double? textSize;

  CustomTimeTable({
    Key? key,
    required CustomTimeTableController controller,
    required this.rowHeight,
    this.textSize,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<CustomTimeTable> createState() => _CustomTimeTableState();
}

class _CustomTimeTableState extends ConsumerState<CustomTimeTable> {
  late CustomTimeTableController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return TableCalendar(
      locale: 'ko_KR',
      daysOfWeekStyle: DaysOfWeekStyle(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: kBorderColor,
            ),
          ),
        ),
        weekendStyle: kTextNormalStyleLarge,
        weekdayStyle: kTextNormalStyleLarge,
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: kTextMainStyleLarge,
      ),
      rangeStartDay: controller.startDay,
      rangeEndDay: controller.endDay,
      rowHeight: widget.rowHeight,
      daysOfWeekHeight: widget.rowHeight,
      firstDay: controller.firstDay,
      lastDay: controller.lastDay,
      focusedDay: controller.focusedDay,
      onDaySelected: controller.onDaySelected,
      selectedDayPredicate: controller.selectedDayPredicate,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, dateTime, _) {
          final date = getDayOfWeek(dateTime);
          if (date == "토요일") {
            return _cellBuilder(
              date: dateTime.day.toString(),
              textColor: Colors.blue,
              textSize: widget.textSize,
            );
          }
          if (date == "일요일") {
            return _cellBuilder(
              date: dateTime.day.toString(),
              textColor: Colors.red,
              textSize: widget.textSize,
            );
          }
          return _cellBuilder(
            date: dateTime.day.toString(),
            textSize: widget.textSize,
          );
        },
        outsideBuilder: (context, dateTime, _) => _cellBuilder(
          textSize: widget.textSize,
          textColor: Colors.black.withOpacity(0.5),
          date: dateTime.day.toString(),
        ),

        // 오늘 날짜 셀의 빌더 함수
        todayBuilder: (context, dateTime, _) => _cellBuilder(
          textSize: widget.textSize,
          color: kBackgroundMainColor,
          date: dateTime.day.toString(),
          border: Border.all(
            color: kTextMainColor,
            width: 2,
          ),
        ),
        // 선택된 날짜 셀의 빌더 함수
        selectedBuilder: (context, dateTime, _) => _cellBuilder(
          color: kMainColor,
          date: dateTime.day.toString(),
          textColor: kTextReverseColor,
          textSize: widget.textSize,
        ),
      ),
      onPageChanged: controller.onPageChanged,
    );
  }

  Widget _cellBuilder({
    Color? color,
    required String date,
    Color? textColor,
    BoxBorder? border,
    double? textSize,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        width: 50,
        height: 50,
        child: Center(
          child: Text(
            date,
            style: kTextNormalStyleLarge.copyWith(
              color: textColor,
              fontSize: textSize ?? kTextLargeSize,
            ),
            softWrap: false,
          ),
        ),
      );
}

class CustomTimeTableController extends ChangeNotifier {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late DateTime? _startDay;
  late DateTime? _endDay;
  final Function()? onDayChange;
  final bool useRange;
  int count = 0;
  bool toggle = true;

  DateTime get focusedDay => _focusedDay;

  DateTime get selectedDay => _focusedDay;

  DateTime get firstDay => _firstDay;

  DateTime get lastDay => _lastDay;

  DateTime? get startDay => _startDay;

  DateTime? get endDay => _endDay;

  CustomTimeTableController({
    required this.useRange,
    DateTime? initDay,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? startDay,
    DateTime? endDay,
    this.onDayChange,
  })  : _focusedDay = initDay ?? DateTime.now(),
        _selectedDay = initDay ?? DateTime.now(),
        _firstDay = firstDay ?? DateTime.utc(2010, 10, 16),
        _lastDay = lastDay ?? DateTime.utc(2030, 3, 14),
        _startDay = null,
        _endDay = null;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _focusedDay = selectedDay;
    _selectedDay = selectedDay;

    if (useRange) {
      if (toggle) {
        _startDay = _selectedDay;
        _endDay = null;
      } else {
        _endDay = _selectedDay;
      }

      if (_startDay != null && _endDay != null) {
        if (_endDay!.isBefore(_startDay!)) {
          final temp = _endDay;
          _endDay = _startDay;
          _startDay = temp;
        }
      }
      toggle = !toggle;
    }

    if (onDayChange != null) onDayChange!();
    notifyListeners();
  }

  bool selectedDayPredicate(DateTime? day) => isSameDay(_selectedDay, day);

  void onPageChanged(DateTime dateTime) {
    _startDay = null;
    _endDay = null;
    onDaySelected(dateTime, dateTime);
  }
}
